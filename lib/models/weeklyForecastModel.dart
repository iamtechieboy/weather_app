import 'dart:convert';

/// weekDay : "Mon"
/// date : "12 july"
/// condition : "Sunny"
/// temp : "12"
/// rainProb : "0"

WeeklyForecastModel weeklyForecastModelFromJson(String str) =>
    WeeklyForecastModel.fromJson(json.decode(str));

String weeklyForecastModelToJson(WeeklyForecastModel data) =>
    json.encode(data.toJson());

class WeeklyForecastModel {
  WeeklyForecastModel({
    String? weekDay,
    String? date,
    String? condition,
    String? temp,
    String? rainProb,
  }) {
    _weekDay = weekDay;
    _date = date;
    _condition = condition;
    _temp = temp;
    _rainProb = rainProb;
  }

  WeeklyForecastModel.fromJson(dynamic json) {
    _weekDay = json['weekDay'];
    _date = json['date'];
    _condition = json['condition'];
    _temp = json['temp'];
    _rainProb = json['rainProb'];
  }

  String? _weekDay;
  String? _date;
  String? _condition;
  String? _temp;
  String? _rainProb;

  WeeklyForecastModel copyWith({
    String? weekDay,
    String? date,
    String? condition,
    String? temp,
    String? rainProb,
  }) =>
      WeeklyForecastModel(
        weekDay: weekDay ?? _weekDay,
        date: date ?? _date,
        condition: condition ?? _condition,
        temp: temp ?? _temp,
        rainProb: rainProb ?? _rainProb,
      );

  String? get weekDay => _weekDay;

  String? get date => _date;

  String? get condition => _condition;

  String? get temp => _temp;

  String? get rainProb => _rainProb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['weekDay'] = _weekDay;
    map['date'] = _date;
    map['condition'] = _condition;
    map['temp'] = _temp;
    map['rainProb'] = _rainProb;
    return map;
  }
}
