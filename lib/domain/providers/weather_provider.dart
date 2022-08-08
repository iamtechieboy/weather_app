import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/logic/network_reopsitory_impl.dart';

import '../../utils/constants.dart';
import '../../utils/hive_utils.dart';
import '../models/cities_model.dart';
import '../models/current_day_model.dart';
import '../models/weekly_forecast_model.dart';

class WeatherProvider extends ChangeNotifier
    with HiveUtil, NetworkRepositoryImpl {
  List<CitiesModel>? citiesModel;
  List<WeeklyForecastModel>? weeklyModel;
  CurrentDayModel? currentDayModel;
  bool isLoadCompleted = false;
  String dropdownValue = "";
  String index = "";

  Future initialLoadingData() async {
    if (await isEmptyBox<CitiesModel>(citiesBox)) {
      citiesModel = await loadingCitiesName();
      addAllBox<CitiesModel>(citiesBox, citiesModel!);
    } else {
      citiesModel = await getBoxAllValue(citiesBox);
    }
    dropdownValue = citiesModel![0].cityName!;
    loadWeather(citiesModel![0]);
  }

  changeIndex(String newIndex) {
    if (index != newIndex) {
      index = newIndex;
      notifyListeners();
    }
  }

  Future loadWeather(CitiesModel citiesModel) async {
    currentDayModel = null;
    weeklyModel = null;
    notifyListeners();

    if (await loadLocalDate()) {
      currentDayModel =
          await getBox<CurrentDayModel>(dailyBox, key: dropdownValue);
      notifyListeners();
    } else {
      loadingCurrentDayWeatherForecast(
              citiesModel.cityName!, citiesModel.linkName!)
          .then(
        (value) => {
          currentDayModel = value,
          saveBox<CurrentDayModel>(dailyBox, currentDayModel!,
              key: dropdownValue),
          notifyListeners(),
        },
      );
    }
    loadingWeeklyWeatherForecast(citiesModel.linkName!).then(
      (value) => {
        weeklyModel = value,
        index = weeklyModel![0].date!,
        weeklyModel,
        notifyListeners(),
      },
    );
  }

  Future<bool> loadLocalDate() async {
    try {
      final format = DateFormat("dd.MM.yyyy");
      var date = format.format(DateTime.now());
      var model = await getBox<CurrentDayModel>(dailyBox, key: dropdownValue);
      if (model!.loadDate == date) {
        currentDayModel = model;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
