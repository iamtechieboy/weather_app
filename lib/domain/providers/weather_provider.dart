import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/logic/network_repository.dart';

import '../../utils/constants.dart';
import '../../utils/hive_utils.dart';
import '../models/cities_model.dart';
import '../models/current_day_model.dart';
import '../models/weekly_forecast_model.dart';

enum ModelState { isInit, isBusy, isSuccess, isError }

class WeatherProvider extends ChangeNotifier with HiveUtil {
  WeatherProvider(this._networkRepository);
  final NetworkRepository _networkRepository;
  List<CitiesModel>? citiesModel;
  List<WeeklyForecastModel>? weeklyModel;
  CurrentDayModel? currentDayModel;
  bool isLoadCompleted = false;
  String dropdownValue = "";
  String index = "";
  Map<dynamic, ModelState> state = {};
  final String tagInitLoad = 'init_load';

  Future initialLoadingData(String tag) async {
    state[tag] = ModelState.isBusy;
    notifyListeners();
    if (await isEmptyBox<CitiesModel>(citiesBox)) {
      citiesModel = await _networkRepository.loadingCitiesName();
      addAllBox<CitiesModel>(citiesBox, citiesModel!);
    } else {
      citiesModel = await getBoxAllValue(citiesBox);
    }
    dropdownValue = citiesModel![0].cityName!;
    loadWeather(citiesModel![0], tag: tag);
  }

  changeIndex(String newIndex) {
    if (index != newIndex) {
      index = newIndex;
      notifyListeners();
    }
  }

  Future loadWeather(CitiesModel citiesModel, {required String tag, bool isChage = false}) async {
    currentDayModel = null;
    weeklyModel = null;
    if (isChage) {
      state[tag] = ModelState.isBusy;
      notifyListeners();
    }

    try {
      if (await loadLocalDate()) {
        currentDayModel = await getBox<CurrentDayModel>(dailyBox, key: dropdownValue);
      } else {
        currentDayModel =
            await _networkRepository.loadingCurrentDayWeatherForecast(citiesModel.cityName!, citiesModel.linkName!);
        saveBox<CurrentDayModel>(dailyBox, currentDayModel!, key: dropdownValue);
      }
      weeklyModel = await _networkRepository.loadingWeeklyWeatherForecast(citiesModel.linkName!);
      index = weeklyModel![0].date!;
      state[tag] = ModelState.isSuccess;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      state[tag] = ModelState.isError;
      notifyListeners();
    }
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
