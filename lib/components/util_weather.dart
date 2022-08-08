import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

import '../domain/models/cities_model.dart';
import '../domain/providers/weather_provider.dart';

mixin UtilWeather {
  Widget loadWeeklyForecastList(WeatherProvider provider) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: provider.weeklyModel!.length,
        itemBuilder: (context, index) {
          var model = provider.weeklyModel![index];
          return itemWeeklyForecast(
            () => provider.changeIndex(model.date!),
            isPressed: provider.index == model.date,
            weekDay: model.weekDay!.substring(0, 3),
            date: model.date!.substring(0, 7),
            situation: model.condition!,
            temperature: model.temp!,
            proximity: model.rainProb!,
          );
        },
      ),
    );
  }

  Widget itemWeeklyForecast(
    Function callBack, {
    required String weekDay,
    required String date,
    required String situation,
    required String temperature,
    required String proximity,
    bool isPressed = false,
  }) {
    var colorTitle = isPressed ? Colors.white : Colors.black;
    var colorDisc = isPressed ? Colors.white : Colors.black26;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: InkWell(
        onTap: () => callBack(),
        borderRadius: BorderRadius.circular(33),
        child: Container(
          width: 66,
          padding:
              const EdgeInsets.only(top: 20, bottom: 15, right: 10, left: 10),
          decoration: BoxDecoration(
            boxShadow: isPressed ? containerBoxShadow : null,
            borderRadius: BorderRadius.circular(33),
            gradient: isPressed ? containerGradient : null,
          ),
          child: Column(
            children: [
              Text(
                weekDay,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colorTitle),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                date,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: colorDisc),
              ),
              Expanded(
                child: Image(
                  image: weatherCond(situation),
                  height: 40,
                  width: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  temperature,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: colorTitle),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: humidityColor(proximity),
                    borderRadius: BorderRadius.circular(18)),
                child: Text(
                  proximity,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return Center(
        child: Row(
      children: const [
        CupertinoActivityIndicator(
          animating: true,
          color: Colors.white,
          radius: 7,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Updating...",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ));
  }

  Widget locationWidgetForAppBar(
      List<CitiesModel> citiesModel, WeatherProvider provider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          menuMaxHeight: 300,
          value: provider.dropdownValue,
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(10),
          icon: const Visibility(
            visible: false,
            child: Icon(Icons.location_on_rounded),
          ),
          underline: null,
          onChanged: (String? newValue) {
            provider.dropdownValue = newValue!;
            for (var element in citiesModel) {
              if (element.cityName == newValue) {
                provider.loadWeather(element);
              }
            }
          },
          items: citiesModel.map((CitiesModel e) {
            return DropdownMenuItem(
              value: e.cityName,
              child: Text(
                textAlign: TextAlign.center,
                e.cityName!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList()),
    );
  }

  Widget iconicText(String assets, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/$assets.png"),
            height: 35,
            width: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    info,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SnackBar snackBarInternetError = const SnackBar(
    content: Text(
      'Not internet connection...',
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.red,
  );

  weatherCond(String situation) {
    String img = 'img_sunny';
    if (situation.trim().contains('ochiq havo')) {
      img = 'img_sunny';
    } else if (situation.trim().contains('bulutli')) {
      img = 'img_cloudy';
    } else if (situation.trim().contains("yomg'ir")) {
      img = 'img_rain';
    } else if (situation.trim().contains("chaqmoq")) {
      img = 'img_thunder_rain';
    } else if (situation.trim().contains("qor")) {
      img = 'img_snowy';
    }
    return AssetImage("assets/$img.png");
  }

  humidityColor(String proximity) {
    double percentage = double.parse(proximity.replaceAll("%", ""));
    if (percentage > 50) {
      return const Color(0xffFF7676);
    } else {
      return const Color(0xff2dbe8d);
    }
  }

  Widget updatedWidget() {
    return const Center(
      child: Text(
        "Update",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
