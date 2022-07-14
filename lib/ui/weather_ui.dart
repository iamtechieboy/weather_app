import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logic/localData.dart';
import 'package:weather_app/logic/networkLayer.dart';
import 'package:weather_app/models/citiesModel.dart';
import 'package:weather_app/models/currentDayModel.dart';
import 'package:weather_app/models/weeklyForecastModel.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/utilWeather.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  State<WeatherMainPage> createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> with UtilWeather {
  List<CitiesModel>? citiesModel;
  List<WeeklyForecastModel>? weeklyModel;
  CurrentDayModel? currentDayModel;
  bool isLoadCompleted = false;
  String dropdownValue = "";
  String _index = "";
  NetworkLayer networkLayer = NetworkLayer();
  LocalData localData = LocalData();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async {
    if (await localData.isEmptyBox<CitiesModel>(citiesBox)) {
      citiesModel = await networkLayer.loadCities();
      localData.saveCities(citiesModel!);
    } else {
      citiesModel = await localData.getCitiesModel();
    }
    dropdownValue = citiesModel![0].cityName!;
    loadWeather(citiesModel![0]);
  }

  Future loadWeather(CitiesModel citiesModel) async {
    setState(() {
      currentDayModel = null;
      weeklyModel = null;
    });
    if (await localData.isEmptyBox<CurrentDayModel>(dailyBox)) {
      networkLayer
          .loadCurrentWeather(citiesModel.cityName!, citiesModel.linkName!)
          .then(
            (value) => {
              setState(
                () {
                  currentDayModel = value;
                  localData.addBox(dailyBox, currentDayModel);
                  currentDayModel;
                },
              ),
            },
          );
    } else {
      currentDayModel = await localData.getCurrentDayModel();
      setState(
        () {
          currentDayModel;
        },
      );
    }

    if (await localData.isEmptyBox<WeeklyForecastModel>(weeklyBox)) {
      networkLayer.loadWeeklyForecast(citiesModel.linkName!).then((value) => {
            setState(
              () {
                weeklyModel = value;
                localData.addAllBox(weeklyBox, weeklyModel!);
                _index = weeklyModel![0].date!;
                weeklyModel;
              },
            ),
          });
    } else {
      weeklyModel = await localData.getWeekly();
      setState(
        () {
          weeklyModel;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            citiesModel != null
                                ? location(citiesModel!)
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
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xffE662E5), Color(0xff5364F0)],
                              transform: GradientRotation(45),
                            ),
                          ),
                          child:
                              currentDayModel == null ? loading() : updated(),
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
                          border: Border.all(color: Colors.white, width: 2)),
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
              currentDayModel != null ? bodyFull() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyFull() {
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
                              "Bugun \n${currentDayModel!.date!}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.right,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: GradientText(
                                currentDayModel!.temp!,
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
                              "Tun : ${currentDayModel!.tempN!}",
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
                      currentDayModel!.situation!,
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
                    image: weatherCond(currentDayModel!.situation!),
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
                                  currentDayModel!.pressure!),
                              iconicText("ic_cloud_wind", "Shamol",
                                  currentDayModel!.wind!),
                              iconicText("ic_sunrise", "Quyosh chiqish",
                                  currentDayModel!.sunrise!)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconicText("ic_raindrops", "Namlik",
                                    currentDayModel!.humidity!),
                                iconicText("ic_moon_line", "Oy holati",
                                    currentDayModel!.moon!),
                                iconicText("ic_sunset", "Quyosh botishi",
                                    currentDayModel!.sunset!)
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
            child: weeklyModel != null
                ? loadWeekly()
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

  Widget loadWeekly() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weeklyModel!.length,
        itemBuilder: (context, index) {
          var model = weeklyModel![index];
          return itemWeeklyForecast(
            () => setState(() {
              _index = model.date!;
            }),
            isPressed: _index == model.date,
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

  Widget loading() {
    return Center(
        child: Row(
      children: const [
        CupertinoActivityIndicator(
          animating: true,
          color: Colors.white,
          radius: 7,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Updating...",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ));
  }

  Widget updated() {
    return const Center(
      child: Text(
        "Update",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }

  Widget location(List<CitiesModel> citiesModel) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          menuMaxHeight: 300,
          value: dropdownValue,
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(10),
          icon: const Visibility(
            visible: false,
            child: Icon(Icons.location_on_rounded),
          ),
          underline: null,
          onChanged: (String? newValue) {
            for (var element in citiesModel) {
              if (element.cityName == newValue) {
                loadWeather(element);
              }
            }
            setState(() {
              dropdownValue = newValue!;
            });
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

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
