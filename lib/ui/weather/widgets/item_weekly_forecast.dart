import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ItemWeeklyForecast extends StatelessWidget {
  ItemWeeklyForecast(
    this.callBack, {
    required this.weekDay,
    required this.date,
    required this.situation,
    required this.temperature,
    required this.proximity,
    this.isPressed = false,
    Key? key,
  }) : super(key: key);

  final Function callBack;
  final String weekDay;
  final String date;
  final String situation;
  final String temperature;
  final String proximity;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var colorTitle = isPressed ? Colors.white : Colors.black;
    var colorDisc = isPressed ? Colors.white : Colors.black26;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: InkWell(
        onTap: () => callBack(),
        borderRadius: BorderRadius.circular(33),
        child: Container(
          width: 66,
          padding: const EdgeInsets.only(top: 20, bottom: 15, right: 10, left: 10),
          decoration: BoxDecoration(
            boxShadow: isPressed ? containerBoxShadow : null,
            borderRadius: BorderRadius.circular(33),
            gradient: isPressed ? containerGradient : null,
          ),
          child: Column(
            children: [
              Text(
                weekDay,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: colorTitle),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                date,
                maxLines: 1,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: colorDisc),
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
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: colorTitle),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(color: humidityColor(proximity), borderRadius: BorderRadius.circular(18)),
                child: Text(
                  proximity,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
