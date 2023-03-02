import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_plus/app_colors.dart';
import 'package:weather_plus/src/app/data/entities/current_weather_response.entity.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'package:weather_plus/src/ui/pages/home/widgets/weather_description.dart';
import 'package:weather_plus/src/ui/pages/home/widgets/weather_header.dart';
import 'package:weather_plus/src/utils/capitalize.dart';
import 'package:weather_plus/src/utils/utils.dart';


class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.currentWeatherResponse, required this.weatherHeader, required this.timeParametersEntity})
      : super(key: key);

  final CurrentWeatherResponseEntity currentWeatherResponse;
  final WeatherHeader weatherHeader;
  final TimeParametersEntity timeParametersEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(10),
      height: 390.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.MorningGradientColors
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          weatherHeader,
          SizedBox(
            height: 200.h,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Image.asset(
                        '${currentWeatherResponse.weather?.first.iconUrl}',
                        width: 135.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '${currentWeatherResponse.main?.temp?.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w900,
                              height: 1,
                              color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '°${timeParametersEntity.units == 'imperial' ? 'F' : timeParametersEntity.units == 'metric' ? 'C' : 'C'  }',
                              style: TextStyle(
                                  fontSize: 55.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Default'),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        capitalizeAllWord(
                            currentWeatherResponse.weather!.first.description!),
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          WeatherDescription(
            currentWeatherResponse: currentWeatherResponse,
          ),
        ],
      ),
    );
  }
}
