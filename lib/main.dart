import 'package:flutter/material.dart';
import 'package:weather_app/ui/weather_ui.dart';
import 'package:weather_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherMainPage(),
      onGenerateRoute: (setting) => Routes.generateRoute(setting),
    );
  }
}
