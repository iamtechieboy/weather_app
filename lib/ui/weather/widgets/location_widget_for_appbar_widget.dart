import 'package:flutter/material.dart';

import '../../../domain/models/cities_model.dart';
import '../../../domain/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class LocationWidgetForAppBar extends StatelessWidget {
  const LocationWidgetForAppBar(this.citiesModel, {Key? key}) : super(key: key);
  final List<CitiesModel> citiesModel;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<WeatherProvider>();
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
                provider.loadWeather(element, tag: provider.tagInitLoad);
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
}
