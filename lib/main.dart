import 'package:flutter/material.dart';
import 'package:legacyweather/LocalDatabase/LocalDatabase.dart';
import 'package:legacyweather/WeatherService/WeatherRepo.dart';
import 'package:legacyweather/wrapper.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalDatabaseCity>(
          create: (context) => LocalDatabaseCity(),
        ),
        Provider<WeatherRepo>(
          create: (context) => WeatherRepo(),
        )
      ],
      child: MaterialApp(
        title: 'Weather by Legacy',
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        theme: ThemeData(
          primaryColor: Color(0xff01286a),
          accentColor: Colors.white,
          //01286a color
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
