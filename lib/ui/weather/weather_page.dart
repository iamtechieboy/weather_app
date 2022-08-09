import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/weather/widgets/wether_full_body_widget.dart';
import 'widgets/loading_widget.dart';
import 'widgets/location_widget_for_appbar_widget.dart';
import 'widgets/updated_widget.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  State<WeatherMainPage> createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        if (provider.citiesModel == null) {
          provider.initialLoadingData(provider.tagInitLoad);
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
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                                    ? LocationWidgetForAppBar(provider.citiesModel!)
                                    : const Padding(
                                        padding: EdgeInsets.only(top: 5, bottom: 10),
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
                              child: provider.state[provider.tagInitLoad] == ModelState.isBusy
                                  ? const LoadingWidget()
                                  : const UpdatedWidget(),
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
                  provider.state[provider.tagInitLoad] == ModelState.isSuccess ? const WeatherFullBody() : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
