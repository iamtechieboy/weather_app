import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

mixin UtilWeather {
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
}
