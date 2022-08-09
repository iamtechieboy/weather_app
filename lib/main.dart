import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/logic/network_reopsitory_impl.dart';
import 'package:weather_app/domain/models/cities_model.dart';
import 'package:weather_app/domain/models/current_day_model.dart';
import 'package:weather_app/domain/models/weekly_forecast_model.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/weather/weather_page.dart';
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
    return MultiProvider(
      providers: [ChangeNotifierProvider<WeatherProvider>(create: (_) => WeatherProvider(NetworkRepositoryImpl()))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WeatherMainPage(),
        onGenerateRoute: (setting) => Routes.generateRoute(setting),
      ),
    );
  }
}
