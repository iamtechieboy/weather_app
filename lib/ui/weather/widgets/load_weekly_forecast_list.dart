import 'package:flutter/material.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';

import 'item_weekly_forecast.dart';

class LoadWeeklyForecastList extends StatelessWidget {
  const LoadWeeklyForecastList(
    this.provider, {
    Key? key,
  }) : super(key: key);

  final WeatherProvider provider;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: provider.weeklyModel!.length,
        itemBuilder: (context, index) {
          var model = provider.weeklyModel![index];
          return ItemWeeklyForecast(
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
}
