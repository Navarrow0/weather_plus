import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_plus/src/app/data/entities/current_weather_response.entity.dart';
import 'package:weather_plus/src/utils/weathernw_icons.dart';

class WeatherDescription extends StatelessWidget {
  const WeatherDescription({Key? key, required this.currentWeatherResponse}) : super(key: key);

  final CurrentWeatherResponseEntity currentWeatherResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconDescription(name: 'Viento', value: '${currentWeatherResponse.wind?.speed} km/h', icon: Weathernw.wind, iconColor: const Color(0xff7c73e6),),
          const IconDescription(name: 'Índice UV', value: '2.1', icon: Weathernw.sun, iconColor: Color(0xffff9a3c),),
          IconDescription(name: 'Humedad', value: '${currentWeatherResponse.main?.humidity }%', icon: Weathernw.water, iconColor:  const Color( 0xff6092ee),),
        ],
      ),
    );
  }
}


class IconDescription extends StatelessWidget {
  const IconDescription({Key? key, required this.name, required this.value, required this.icon, required this.iconColor}) : super(key: key);

  final String name;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          margin: REdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff7090B0).withAlpha(40),
                offset: const Offset(0, 16),
                blurRadius: 40
              )
            ]
          ),
          padding: REdgeInsets.all(17),
          child: Icon(icon, color: iconColor, size: 23.sp,),
        ),

        Text(value, style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
          color: const Color.fromRGBO(255, 255, 255, 0.7)
        ),),
        Text(name, style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            color: const Color.fromRGBO(255, 255, 255, 0.6)
        ),)
      ],
    );
  }
}
