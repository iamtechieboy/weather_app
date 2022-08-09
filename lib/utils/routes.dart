import 'package:flutter/material.dart';
import 'package:weather_app/ui/weather/weather_page.dart';

class Routes {
  static const mainPage = "/mainPage";

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        default:
          return MaterialPageRoute(
              builder: (context) => const WeatherMainPage());
      }
    } catch (e) {
      print("ERROR => routes \n$e");
    }
    return null;
  }
}
