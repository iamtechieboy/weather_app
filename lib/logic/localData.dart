import 'package:hive/hive.dart';
import 'package:weather_app/models/citiesModel.dart';
import 'package:weather_app/models/currentDayModel.dart';
import 'package:weather_app/models/weeklyForecastModel.dart';
import 'package:weather_app/utils/HiveUtils.dart';
import 'package:weather_app/utils/constants.dart';

class LocalData with HiveUtils {

  saveCities(List<CitiesModel> citiesModel) {
    addAllBox(citiesBox, citiesModel);
  }

  Future<List<CitiesModel>?> getCitiesModel() async {
    List<CitiesModel>? list;
    await getAllBox<CitiesModel>(citiesBox)
        .then((value) => {list = value.values.toList()});
    return Future.value(list);
  }

  Future<List<WeeklyForecastModel>?> getWeekly() async {
    List<WeeklyForecastModel>? list;
    await getAllBox<WeeklyForecastModel>(weeklyBox)
        .then((value) => {list = value.values.toList()});
    return Future.value(list);
  }

  Future<CurrentDayModel>? getCurrentDayModel() async {
    CurrentDayModel? list;
    await getAllBox<CurrentDayModel>(dailyBox)
        .then((value) => {list = value.values.first});
    return Future.value(list);
  }
}
