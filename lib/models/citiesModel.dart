import 'dart:convert';

/// cityName : "Tashkent"
/// linkName : "tashkent"

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    String? cityName,
    String? linkName,
  }) {
    _cityName = cityName;
    _linkName = linkName;
  }

  CitiesModel.fromJson(dynamic json) {
    _cityName = json['cityName'];
    _linkName = json['linkName'];
  }

  String? _cityName;
  String? _linkName;

  CitiesModel copyWith({
    String? cityName,
    String? linkName,
  }) =>
      CitiesModel(
        cityName: cityName ?? _cityName,
        linkName: linkName ?? _linkName,
      );

  String? get cityName => _cityName;

  String? get linkName => _linkName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cityName'] = _cityName;
    map['linkName'] = _linkName;
    return map;
  }
}
