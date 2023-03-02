import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momentum/momentum.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_plus/app_colors.dart';
import 'package:weather_plus/src/app/components/auth/home.controller.dart';
import 'package:weather_plus/src/ui/pages/home/widgets/weather_forecasting.dart';
import 'package:weather_plus/src/ui/pages/home/widgets/weather_header.dart';
import 'package:weather_plus/src/ui/pages/home/widgets/weather_card.dart';
import 'package:weather_plus/src/ui/pages/location/location_page.dart';
import 'package:weather_plus/src/utils/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends MomentumState<MainPage> {
  HomeController? _homeController;

  @override
  void initMomentumState() {
    _homeController ??= Momentum.controller<HomeController>(context);
    super.initMomentumState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: MomentumBuilder(
          controllers: const [HomeController],
          builder: (context, snapshot) {
            return FutureBuilder(
              future: _homeController?.getCurrentWeather(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.when((response) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          WeatherCard(
                            weatherHeader: WeatherHeader(
                              onSelected: (value){
                                if (value == 1){
                                  _homeController?.updateWeather(units: Units.METRIC);
                                }
                                if (value == 2){
                                  _homeController?.updateWeather(units: Units.IMPERIAL);
                                }
                              },
                              onTapSelectCity: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LocationsPage(),
                                  ),
                                );
                              },
                              locationName: response.name!,
                            ),
                            currentWeatherResponse: response,
                            timeParametersEntity:  _homeController!.model.timeParametersEntity!,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          FutureBuilder(
                            future: _homeController?.getWeatherPerHour(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.when((response) {
                                  return WeatherForecasting(
                                    response: response,
                                  );
                                }, (error) => Text(error));
                              }

                              return const SizedBox();
                            },
                          )
                        ],
                      ),
                    );
                  }, (error) => Text(error));
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
