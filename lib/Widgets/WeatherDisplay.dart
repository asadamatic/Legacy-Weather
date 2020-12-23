import 'package:flutter/material.dart';
import 'package:legacyweather/DataModels/CityData.dart';
import 'package:legacyweather/DataModels/WeatherModel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;
  final City city;

  WeatherDisplay({this.weather, this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(city.name,style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(weather.getTemp.round().toString()+"\u00B0C",style: TextStyle(color: Colors.white, fontSize: 50),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(weather.getMinTemp.round().toString()+"\u00B0C",style: TextStyle(color: Colors.white, fontSize: 30),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Min",style: TextStyle(color: Colors.white, fontSize: 14),),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(weather.getMaxTemp.round().toString()+"\u00B0C",style: TextStyle(color: Colors.white, fontSize: 30),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Max",style: TextStyle(color: Colors.white, fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 5.0,
                    backgroundColor: Colors.white24,
                    percent: double.parse((weather.humidity/100).toString()),
                    center: Text("${weather.humidity.round()}%", style: TextStyle(color: Colors.white, fontSize: 22.0),),
                    progressColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Humidity",style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget weatherIcon() {


  }
}

