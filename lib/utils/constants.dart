import 'package:flutter/material.dart';

var containerGradient = const LinearGradient(
  colors: [
    Color(0xffE662E5),
    Color(0xff5364F0),
  ],
  transform: GradientRotation(120),
);

var containerBoxShadow = [
  BoxShadow(
    color: const Color(0xff5f68ed).withOpacity(0.4),
    blurRadius: 20,
    offset: const Offset(2, 4),
  )
];

humidityColor(String proximity) {
  double percentage = double.parse(proximity.replaceAll("%", ""));
  if (percentage > 50) {
    return const Color(0xffFF7676);
  } else {
    return const Color(0xff2dbe8d);
  }
}

SnackBar snackBarInternetError = const SnackBar(
  content: Text(
    'Not internet connection...',
    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
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

const String citiesBox = "cities_box";
const String dailyBox = "daily_box";
const String weeklyBox = "weekly_box";

const String baseUrl = 'https://obhavo.uz/';
