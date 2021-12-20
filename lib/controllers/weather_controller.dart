import 'package:get/get.dart';
import 'package:legacyweather/data_models/city.dart';
import 'package:legacyweather/data_models/weather.dart';
import 'package:legacyweather/local_database/local_database.dart';
import 'package:legacyweather/weather_service/weather_repo.dart';

class WeatherController extends GetxController {
  List<Weather> weatherData = [];
  List<City> cities = [];
  bool isLoading = false;

  LocalDatabase _localDatabase = LocalDatabase();
  WeatherNetwork _weatherNetwork = WeatherNetwork();
  @override
  void onInit() async {
    _localDatabase.getCityList().listen((citiesList) async {
      isLoading = true;
      cities = citiesList;
      weatherData = await _weatherNetwork.getWeatherList(cities);
      isLoading = false;
      update();
    });

    super.onInit();
  }

  addCity(City city) async {
    await _localDatabase.insertData(city);
    cities.add(city);
    weatherData.add(await _weatherNetwork.getWeather(city));
    update();
  }

  removeCity(City city) async {
    await _localDatabase.delete(city);
    cities.remove(city);
    update();
  }
}
