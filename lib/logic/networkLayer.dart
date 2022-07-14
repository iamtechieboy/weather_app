import 'dart:io';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:weather_app/models/citiesModel.dart';
import 'package:weather_app/models/weeklyForecastModel.dart';

import '../models/currentDayModel.dart';
import '../models/citiesModel.dart';

class NetworkLayer {
  String BASE_URL = 'https://obhavo.uz/';

  Future<List<CitiesModel>?> loadCities() async {
    try {
      var response = await get(Uri.parse(BASE_URL));
      if (response.statusCode == 200) {
        List<CitiesModel> mapData = [];
        var row = parse(response.body)
            .querySelectorAll("div.container")
            .last
            .querySelectorAll("ul.list-c, ul");
        var cities = row.first.querySelectorAll("a,a");
        for (var city in cities) {
          String? cityName = city.nodes.first.text.toString();
          String? cityLink = city.attributes['href']?.replaceAll(BASE_URL, "");
          mapData.add(CitiesModel(cityName: cityName, linkName: cityLink));
        }
        return mapData;
      }
    } on SocketException {
      print('Error with connection internet');
    } catch (e) {
      print('getCountryBase: $e');
    }
    return null;
  }

  Future<CurrentDayModel?> loadCurrentWeather(
      String cityName, String link) async {
    try {
      var response = await get(Uri.parse("$BASE_URL$link"));
      if (response.statusCode == 200) {
        var row = parse(response.body).querySelector('div.padd-block');
        String today =
            row!.querySelector("div.current-day")!.text.split(",").last.trim();
        String temp = row
            .querySelector("div.current-forecast")!
            .querySelectorAll("span,span")[1]
            .querySelector("strong,strong")!
            .text;
        String tempN = row
            .querySelector("div.current-forecast")!
            .querySelectorAll("span,span")[2]
            .text;
        String? condition = row
            .querySelector("div.current-forecast-desc")!
            .text
            .split(",")
            .last
            .trim();
        String humidity = row
            .querySelector("div.col-1")!
            .querySelectorAll("p,p")[0]
            .text
            .split(":")
            .last
            .trim();
        String wind = row
            .querySelector("div.col-1")!
            .querySelectorAll("p,p")[1]
            .text
            .split(",")
            .last
            .trim();
        String pressure = row
            .querySelector("div.col-1")!
            .querySelectorAll("p,p")[2]
            .text
            .split(":")
            .last
            .trim()
            ;
        String moon = row
            .querySelector("div.col-2")!
            .querySelectorAll("p,p")[0]
            .text
            .split(":")
            .last
            .trim();
        var sunRiseRow = row
            .querySelector("div.col-2")!
            .querySelectorAll("p,p")[1]
            .text
            .split(":");
        String sunrise = "${sunRiseRow[1]}:${sunRiseRow[2]}".trim();
        var sunsetRow = row
            .querySelector("div.col-2")!
            .querySelectorAll("p,p")[2]
            .text
            .split(":");
        String sunset = "${sunsetRow[1]}:${sunsetRow[2]}".trim();

        return CurrentDayModel(
            cityName: cityName,
            date: today,
            temp: temp,
            tempN: tempN,
            situation: condition,
            humidity: humidity,
            wind: wind,
            pressure: pressure,
            moon: moon,
            sunrise: sunrise,
            sunset: sunset);
      }
    } on SocketException {
      print('Error with connection internet');
    } catch (e) {
      print('getCountryBase: $e');
    }
    return null;
  }

  Future<List<WeeklyForecastModel>?> loadWeeklyForecast(String link) async {
    try {
      var response = await get(Uri.parse("$BASE_URL$link"));
      if (response.statusCode == 200) {
        List<WeeklyForecastModel> weeklyForecastModel = [];
        var table = parse(response.body).querySelector('table.weather-table');
        var rows = table!.querySelectorAll("tr,tr");
        for (int i = 1; i <= 7; i++) {
          var weekDay = rows[i].querySelector("strong,strong")!.text;
          var date = rows[i].querySelector("div,div")!.text;
          var temp = rows[i].querySelector("span.forecast-day")!.text;
          var condition = rows[i]
              .querySelector("td.weather-row-desc")!
              .text
              .toString()
              .trim();
          var rainProb = rows[i]
              .querySelector("td.weather-row-pop")!
              .text
              .toString()
              .trim();

          weeklyForecastModel.add(WeeklyForecastModel(
              temp: temp,
              condition: condition,
              date: date,
              rainProb: rainProb,
              weekDay: weekDay));
        }
        return weeklyForecastModel;
      }
    } on SocketException {
      print('Error with connection internet');
    } catch (e) {
      print('getCountryBase: $e');
    }
    return null;
  }
}
