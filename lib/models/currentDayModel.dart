import 'dart:convert';

import 'package:hive/hive.dart';
/// cityName : "Tashkent"
/// date : "13 July"
/// situation : "Sunny"
/// humidity : "23"
/// wind : "4.3 m/s"
/// pressure : "758 "
/// moon : "To`lin oy"
/// sunset : "04:53"
/// sunrise : "19:43"
/// temp : "+33"
/// tempN : "+23"

part 'currentDayModel.g.dart';

CurrentDayModel currentDayModelFromJson(String str) => CurrentDayModel.fromJson(json.decode(str));
String currentDayModelToJson(CurrentDayModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class CurrentDayModel extends HiveObject {
  CurrentDayModel({
      String? cityName, 
      String? date, 
      String? situation, 
      String? humidity, 
      String? wind, 
      String? pressure, 
      String? moon, 
      String? sunset, 
      String? sunrise, 
      String? temp, 
      String? tempN,}){
    _cityName = cityName;
    _date = date;
    _situation = situation;
    _humidity = humidity;
    _wind = wind;
    _pressure = pressure;
    _moon = moon;
    _sunset = sunset;
    _sunrise = sunrise;
    _temp = temp;
    _tempN = tempN;
}

  CurrentDayModel.fromJson(dynamic json) {
    _cityName = json['cityName'];
    _date = json['date'];
    _situation = json['situation'];
    _humidity = json['humidity'];
    _wind = json['wind'];
    _pressure = json['pressure'];
    _moon = json['moon'];
    _sunset = json['sunset'];
    _sunrise = json['sunrise'];
    _temp = json['temp'];
    _tempN = json['tempN'];
  }

  @HiveField(0)
  String? _cityName;
  @HiveField(1)
  String? _date;
  @HiveField(2)
  String? _situation;
  @HiveField(3)
  String? _humidity;
  @HiveField(4)
  String? _wind;
  @HiveField(5)
  String? _pressure;
  @HiveField(6)
  String? _moon;
  @HiveField(7)
  String? _sunset;
  @HiveField(8)
  String? _sunrise;
  @HiveField(9)
  String? _temp;
  @HiveField(10)
  String? _tempN;

CurrentDayModel copyWith({  String? cityName,
  String? date,
  String? situation,
  String? humidity,
  String? wind,
  String? pressure,
  String? moon,
  String? sunset,
  String? sunrise,
  String? temp,
  String? tempN,
}) => CurrentDayModel(  cityName: cityName ?? _cityName,
  date: date ?? _date,
  situation: situation ?? _situation,
  humidity: humidity ?? _humidity,
  wind: wind ?? _wind,
  pressure: pressure ?? _pressure,
  moon: moon ?? _moon,
  sunset: sunset ?? _sunset,
  sunrise: sunrise ?? _sunrise,
  temp: temp ?? _temp,
  tempN: tempN ?? _tempN,
);
  String? get cityName => _cityName;
  String? get date => _date;
  String? get situation => _situation;
  String? get humidity => _humidity;
  String? get wind => _wind;
  String? get pressure => _pressure;
  String? get moon => _moon;
  String? get sunset => _sunset;
  String? get sunrise => _sunrise;
  String? get temp => _temp;
  String? get tempN => _tempN;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cityName'] = _cityName;
    map['date'] = _date;
    map['situation'] = _situation;
    map['humidity'] = _humidity;
    map['wind'] = _wind;
    map['pressure'] = _pressure;
    map['moon'] = _moon;
    map['sunset'] = _sunset;
    map['sunrise'] = _sunrise;
    map['temp'] = _temp;
    map['tempN'] = _tempN;
    return map;
  }

}