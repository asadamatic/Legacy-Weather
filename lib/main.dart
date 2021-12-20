import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legacyweather/constants/values.dart';
import 'package:legacyweather/controllers/weather_controller.dart';
import 'package:legacyweather/local_database/local_database.dart';
import 'package:legacyweather/screens/welcome_screen.dart';
import 'package:legacyweather/weather_service/weather_repo.dart';
import 'package:legacyweather/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather by Legacy',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primaryColor: primaryColor,
        //01286a color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
      ),
      themeMode: ThemeMode.system,
      home: WelcomeScreen(),
    );
  }
}
