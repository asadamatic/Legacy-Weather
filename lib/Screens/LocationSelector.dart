import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legacyweather/DataModels/CityData.dart';
import 'package:legacyweather/LocalDatabase/LocalDatabase.dart';
import 'package:provider/provider.dart';

class LocationSelector extends StatefulWidget {
  final Function selectScreen;
  LocationSelector({this.selectScreen});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {

  Future<List<City>> future;
  List<City> cities = List();
  List<City> filteredList = List();
  TextEditingController searchController = TextEditingController();

  void clearSearch(){

    setState(() {

      searchController.clear();
      filteredList = cities;
    });
  }
  void filterData(search){

    setState(() {
      if (search.isEmpty){

        filteredList = cities;
      }else{
        filteredList = cities;
        List<City> temporaryList = List();

        for (int index = 0; index < filteredList.length; index++){

          if (filteredList[index].name.toLowerCase().contains(search.toLowerCase())){
            temporaryList.add(filteredList[index]);
          }
        }
        filteredList = temporaryList;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = getCityList();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text('Choose Location'),
        ),
        body: FutureBuilder(
          future:  future,
          builder: (context, snapshot) {
              if (snapshot.hasData){
                return Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 10.0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 4.0, 12.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search for your city',
                                  border: InputBorder.none,
                                ),
                                onChanged: (queryText){
                                  filterData(queryText);
                                },
                              ),
                            ),
                            GestureDetector(
                              child: Text('Clear', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.8), fontWeight: FontWeight.w700, letterSpacing: .8),),
                              onTap: (){
                                clearSearch();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return FlatButton(
                              onPressed: (){

                                widget.selectScreen != null ?
                                addCity(filteredList[index]) : addNewCity(filteredList[index]);
                              },
                              child: Container(
                                child: Text(filteredList[index].name, style: TextStyle(fontSize: 20.0, color: Color(0xff01286a).withOpacity(.6),)),
                                padding: const EdgeInsets.all(15.0),
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                );
              }
              return Center(child: Container(
                child: FlareActor("Assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
                height: 200,
                width: 200,
              ));
            }),
      ),
    );
  }

  void addCity(City city) async{

    await Provider.of<LocalDatabaseCity>(context, listen: false).insertData(city);

    widget.selectScreen();
  }

  void addNewCity(City city) async{

    await Provider.of<LocalDatabaseCity>(context, listen: false).insertData(city);
    Navigator.of(context).pop();
  }
  City fromJson(Map<String, dynamic> json) {

    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Future<List<City>> getCityList () async{

    final response = await DefaultAssetBundle.of(context).loadString('Assets/citylist.json');
    final decoded = await customCompute(response);
    setState(() {
      cities = decoded.map<City>((json) => fromJson(json)).toList();
      filteredList = decoded.map<City>((json) => fromJson(json)).toList();
    });
    return decoded.map<City>((json) => fromJson(json)).toList();
  }

  customCompute(String response) async{

    return await compute(jsonDecode, response);
  }
}

