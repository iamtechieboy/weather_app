// Colors

import 'package:flutter/cupertino.dart';

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

const String citiesBox = "cities_box";
const String dailyBox = "daily_box";
const String weeklyBox = "weekly_box";
