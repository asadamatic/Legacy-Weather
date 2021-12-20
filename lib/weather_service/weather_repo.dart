import 'package:get/get.dart';
import 'package:legacyweather/constants/api_key.dart';
import 'package:legacyweather/data_models/city.dart';
import 'dart:convert';
import 'package:legacyweather/data_models/weather.dart';

class WeatherNetwork extends GetConnect {
  String openWeatherAPI(String cityName) =>
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

  Future<List<Weather>> getWeatherList(List<City> cities) async {
    List<Weather> weatherList = [];
    for (City city in cities) {
      final Response result = await get(openWeatherAPI(city.name!));
      if (result.statusCode != 200) throw Exception();

      weatherList.add(parsedJson(result.bodyString));
    }
    return weatherList;
  }

  Future<Weather> getWeather(City city) async {
    final Response result = await get(openWeatherAPI(city.name!));
    if (result.statusCode != 200) throw Exception();
    return parsedJson(result.bodyString);
  }

  Weather parsedJson(final response) {
    final jsonDecoded = json.decode(response);
    final Map<String, dynamic> jsonMain = jsonDecoded["main"];
    final Map<String, dynamic> jsonSys = jsonDecoded["sys"];
    final Map<String, dynamic> jsonWeather = jsonDecoded["weather"][0];
    final Map<String, dynamic> newMap = {};
    newMap.addAll(jsonMain);
    newMap.addAll(jsonSys);
    newMap.addAll(jsonWeather);
    newMap.addAll(jsonDecoded);
    return Weather.fromJson(newMap);
  }
}
