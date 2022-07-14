import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/models/citiesModel.dart';
import 'package:weather_app/models/currentDayModel.dart';
import 'package:weather_app/models/weeklyForecastModel.dart';
import 'package:weather_app/ui/weather_ui.dart';
import 'package:weather_app/utils/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CitiesModel>(CitiesModelAdapter());
  Hive.registerAdapter<CurrentDayModel>(CurrentDayModelAdapter());
  Hive.registerAdapter<WeeklyForecastModel>(WeeklyForecastModelAdapter());
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
