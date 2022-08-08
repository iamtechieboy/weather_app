import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/cities_model.dart';
import 'package:weather_app/domain/models/current_day_model.dart';
import 'package:weather_app/domain/models/weekly_forecast_model.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/utils/hive_utils.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/components/util_weather.dart';
import '../components/gradient_text.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  State<WeatherMainPage> createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> with UtilWeather {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        if (provider.citiesModel == null) {
          provider.initialLoadingData();
        } else {
          null;
        }
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFEF7FF), Color(0xffFCEBFF)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x289a60e5),
                                blurRadius: 30,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Image(
                              height: 20,
                              width: 20,
                              image: AssetImage("assets/ic_setting.png"),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xff6764EF),
                                ),
                                provider.citiesModel != null
                                    ? locationWidgetForAppBar(
                                        provider.citiesModel!, provider)
                                    : const Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 10),
                                        child: Text(
                                          "Searching...",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Container(
                              height: 22,
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffE662E5),
                                    Color(0xff5364F0)
                                  ],
                                  transform: GradientRotation(45),
                                ),
                              ),
                              child: provider.currentDayModel == null
                                  ? loadingWidget()
                                  : updatedWidget(),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x289a60e5),
                                  blurRadius: 30,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: const Center(
                            child: Image(
                              height: 50,
                              width: 50,
                              image: AssetImage("assets/profile.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  provider.currentDayModel != null
                      ? fullWeatherBody(provider)
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget fullWeatherBody(WeatherProvider provider) {
    return Flexible(
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 225,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 23),
                  child: Container(
                    height: 202,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xffE662E5), Color(0xff5364F0)],
                          transform: GradientRotation(50),
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x4f5264f0),
                              blurRadius: 30,
                              offset: Offset(10, 15))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 26, top: 24),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Bugun \n${provider.currentDayModel!.date!}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.right,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: GradientText(
                                provider.currentDayModel!.temp!,
                                style: const TextStyle(
                                    fontSize: 75,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffffffff),
                                    Color(0xffD2C4FF)
                                  ],
                                  transform: GradientRotation(90),
                                ),
                              ),
                            ),
                            Text(
                              "Tun : ${provider.currentDayModel!.tempN!}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, bottom: 23),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      provider.currentDayModel!.situation!,
                      style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Image(
                    image: weatherCond(provider.currentDayModel!.situation!),
                    height: 160,
                    width: 160,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0d555555),
                    blurRadius: 30,
                    offset: Offset(5, 15),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Image(
                              image: AssetImage("assets/ic_wind.png"),
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Air quality",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x14000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 20),
                            ],
                          ),
                          child: const Image(
                            image: AssetImage("assets/ic_refresh.png"),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconicText("ic_waves", "Bosim",
                                  provider.currentDayModel!.pressure!),
                              iconicText("ic_cloud_wind", "Shamol",
                                  provider.currentDayModel!.wind!),
                              iconicText("ic_sunrise", "Quyosh chiqish",
                                  provider.currentDayModel!.sunrise!)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconicText("ic_raindrops", "Namlik",
                                    provider.currentDayModel!.humidity!),
                                iconicText("ic_moon_line", "Oy holati",
                                    provider.currentDayModel!.moon!),
                                iconicText("ic_sunset", "Quyosh botishi",
                                    provider.currentDayModel!.sunset!)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Weekly forecast",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 250,
            child: provider.weeklyModel != null
                ? loadWeeklyForecastList(provider)
                : const CupertinoActivityIndicator(
                    animating: true,
                    color: Colors.white,
                    radius: 10,
                  ),
          ),
        ],
      ),
    );
  }
}
