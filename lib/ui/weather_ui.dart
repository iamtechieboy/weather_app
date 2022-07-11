import 'package:flutter/material.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  State<WeatherMainPage> createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image(image: AssetImage("assets/ic_setting.png"),),
            )
          ],
        ),
      ),
    );
  }
}
