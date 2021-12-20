import 'package:intl/intl.dart';

class Weather {
  final temp;
  final pressure;
  final humidity;
  final tempMax;
  final tempMin;
  final icon;
  final main;
  final description;
  final sunset;
  final sunrise;
  final country;
  final timezone;
  double? get getTemp => temp - 272.5;
  double? get getMaxTemp => tempMax - 272.5;
  double? get getMinTemp => tempMin - 272.5;
  DateTime? get sunsetFromMilliseconds => DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
  DateTime? get sunriseFromMilliseconds => DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
  DateTime? get sunsetTime => sunsetFromMilliseconds!.add(Duration(seconds: timezone - sunsetFromMilliseconds!.timeZoneOffset.inSeconds));
  DateTime? get sunriseTime => sunriseFromMilliseconds!.add(Duration(seconds: timezone - sunriseFromMilliseconds!.timeZoneOffset.inSeconds));
  int? get timeDifference => DateTime.fromMillisecondsSinceEpoch(sunset * 1000)
      .difference(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000))
      .inHours;
  int? get currentHours => DateTime.now()
      .difference(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000))
      .inHours;
  double? get sunPosition => currentHours! / timeDifference!;
  Weather(
      this.temp,
      this.pressure,
      this.humidity,
      this.tempMax,
      this.tempMin,
      this.icon,
      this.main,
      this.description,
      this.sunset,
      this.sunrise,
      this.country, this.timezone);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        json["temp"],
        json["pressure"],
        json["humidity"],
        json["temp_max"],
        json["temp_min"],
        json["icon"],
        json["main"],
        json["description"],
        json['sunset'],
        json['sunrise'],
        json['country'],
    json['timezone']);
  }
}
