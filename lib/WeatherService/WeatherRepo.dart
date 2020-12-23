import 'package:http/http.dart' as http;
import 'package:legacyweather/DataModels/CityData.dart';
import 'dart:convert';
import 'package:legacyweather/DataModels/WeatherModel.dart';
import 'package:merge_map/merge_map.dart';


class WeatherRepo{

  Future<WeatherModel> getWeather(City city) async{

    final result = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?id=${city.id}&APPID=eb4fdd6ba32007915f8e4ff410e33e52");

    if(result.statusCode != 200)
      throw Exception();

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response){
    final jsonDecoded = json.decode(response);
    final Map jsonMain = jsonDecoded["main"];
    final List jsonWeather = jsonDecoded['weather'];
    return WeatherModel.fromJson(mergeMap([jsonMain, jsonWeather[0]]));
  }
}