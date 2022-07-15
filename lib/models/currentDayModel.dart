import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'currentDayModel.g.dart';

/// loadDate : "12,15,15"
/// date : "13 July"
/// cityName : "Tashkent"
/// situation : "Sunny"
/// humidity : "23"
/// wind : "4.3 m/s"
/// pressure : "758 "
/// moon : "To`lin oy"
/// sunset : "04:53"
/// sunrise : "19:43"
/// temp : "+33"
/// tempN : "+23"

CurrentDayModel currentDayModelFromJson(String str) =>
    CurrentDayModel.fromJson(json.decode(str));

String currentDayModelToJson(CurrentDayModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 2)
class CurrentDayModel extends HiveObject {
  CurrentDayModel({
    String? loadDate,
    String? date,
    String? cityName,
    String? situation,
    String? humidity,
    String? wind,
    String? pressure,
    String? moon,
    String? sunset,
    String? sunrise,
    String? temp,
    String? tempN,
  }) {
    _loadDate = loadDate;
    _date = date;
    _cityName = cityName;
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
    _loadDate = json['loadDate'];
    _date = json['date'];
    _cityName = json['cityName'];
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
  String? _loadDate;
  @HiveField(1)
  String? _date;
  @HiveField(2)
  String? _cityName;
  @HiveField(3)
  String? _situation;
  @HiveField(4)
  String? _humidity;
  @HiveField(5)
  String? _wind;
  @HiveField(6)
  String? _pressure;
  @HiveField(7)
  String? _moon;
  @HiveField(8)
  String? _sunset;
  @HiveField(9)
  String? _sunrise;
  @HiveField(10)
  String? _temp;
  @HiveField(11)
  String? _tempN;

  CurrentDayModel copyWith({
    String? loadDate,
    String? date,
    String? cityName,
    String? situation,
    String? humidity,
    String? wind,
    String? pressure,
    String? moon,
    String? sunset,
    String? sunrise,
    String? temp,
    String? tempN,
  }) =>
      CurrentDayModel(
        loadDate: loadDate ?? _loadDate,
        date: date ?? _date,
        cityName: cityName ?? _cityName,
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

  String? get loadDate => _loadDate;

  String? get date => _date;

  String? get cityName => _cityName;

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
    map['loadDate'] = _loadDate;
    map['date'] = _date;
    map['cityName'] = _cityName;
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
