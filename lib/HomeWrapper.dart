import 'package:flutter/material.dart';
import 'package:legacyweather/LocalDatabase/LocalDatabase.dart';
import 'package:legacyweather/Screens/HomeScreen.dart';
import 'package:legacyweather/Screens/LocationSelector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWrapper extends StatefulWidget {

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {

  void selectScreen() async{

    setState(() {
      setVisitingValue();
    });
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<LocalDatabaseCity>(context, listen: false).initializeDB();
    return FutureBuilder<bool>(
      future: getVisitingValue(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){

        if (snapshot.hasData){

          if (snapshot.data == true){

            return HomeScreen();
          }else{

            return LocationSelector(selectScreen: selectScreen);
          }
        }else{

          return Scaffold();
        }
      },
    );
  }
}

Future<bool> getVisitingValue() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('homeWrapperVisitingValue') ?? false;
}

setVisitingValue() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('homeWrapperVisitingValue', true);
}
