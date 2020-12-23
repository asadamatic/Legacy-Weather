import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legacyweather/DataModels/CityData.dart';
import 'package:legacyweather/DataModels/WeatherModel.dart';
import 'package:legacyweather/LocalDatabase/LocalDatabase.dart';
import 'package:legacyweather/Screens/LocationSelector.dart';
import 'package:legacyweather/WeatherService/WeatherRepo.dart';
import 'package:legacyweather/Widgets/WeatherDisplay.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            elevation: 0.0,
            brightness: Brightness.dark,
            leading: IconButton(
              icon: Icon(
                Icons.info_outline,
              ),
              onPressed: (){
                showAboutDialog(context: context,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('App Icon by ', style: TextStyle(color: Colors.grey),),
                        GestureDetector(
                            onTap: () async{
                              await launch('https://flaticon.com');
                            },
                            child: Text('Flaticon.com', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey),)
                        ),
                      ],
                    )
                  ],
                  applicationName: 'Weather by Legacy',
                  applicationVersion: '1.0.1',
                  applicationIcon: Image(
                    image: AssetImage('Assets/icon.png'),
                    height: 60.0,
                    width: 60.0,
                  ),
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () async{
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationSelector()));
                  setState(() {

                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                ),
                onPressed: (){
                  setState(() {

                  });
                },
              )
            ],
          ),
          body: WeatherUpdates()
      ),
    );
  }
}

class WeatherUpdates extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<City>>(
        stream: Provider.of<LocalDatabaseCity>(context).getCityList(),
        builder: (context, snapshot) {

          if (snapshot.hasData){

            return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index){

                  return FutureBuilder<WeatherModel>(
                      future: Provider.of<WeatherRepo>(context).getWeather(snapshot.data[index]),
                      builder: (context, datasnapshot) {

                        if (datasnapshot.hasData){

                          return WeatherDisplay(weather: datasnapshot.data, city: snapshot.data[index]);
                        }else if (datasnapshot.hasError){

                          return ErrorWidget();
                        }
                        return Center(child: CircularProgressIndicator(),);
                      }
                  );
                });

          }else{

            return Center(child: CircularProgressIndicator(),);
          }

        }
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('Assets/upsetcloud.png'),
          height: 170.0,
        ),
        SizedBox(height: 20.0,),
        Text('Please check your internet connection', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Theme.of(context).accentColor),),
      ],
    ));
  }
}

