import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:legacyweather/constants/values.dart';
import 'package:legacyweather/controllers/weather_controller.dart';
import 'package:legacyweather/screens/location_selector.dart';
import 'package:legacyweather/Widgets/weather_display.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _weatherController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.info_outline,
              ),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'App Icon by ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                            onTap: () async {
                              await launch('https://flaticon.com');
                            },
                            child: Text(
                              'Flaticon.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey),
                            )),
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
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationSelector()));
                },
              ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: WeatherUpdates()),
    );
  }
}

class WeatherUpdates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (_weatherController) {
      return _weatherController.weatherData.isEmpty
          ? Center(
              child: Text(
                'Add a location to see weather updates!',
                style: TextStyle(color: Colors.white),
              ),
            )
          : PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _weatherController.cities.length,
              itemBuilder: (context, index) {
                return _weatherController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : WeatherDisplay(
                        weather: _weatherController.weatherData[index],
                        city: _weatherController.cities[index]);
              });
    });
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('Assets/upsetcloud.png'),
          height: 170.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Please check your internet connection',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0, color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    ));
  }
}
