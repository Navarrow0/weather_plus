import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:weather_plus/src/app/data/entities/weather_forecast_response.entity.dart';

class WeatherForecasting extends StatelessWidget {
  const WeatherForecasting({Key? key, required this.response})
      : super(key: key);

  final WeatherForecastResponseEntity response;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(left: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                IconlyLight.time_circle,
                size: 25.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'Predicción horaria',
                style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5.sp),
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: response.list.length,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return _ForecastWeatherCard(
                  img: response.list[index].weather!.first.iconUrl,
                  date: response.list[index].dt_txt!,
                  temp: '${response.list[index].main!.temp?.toStringAsFixed(0)}\u00B0',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ForecastWeatherCard extends StatelessWidget {
  const _ForecastWeatherCard(
      {Key? key, required this.img, required this.date, required this.temp})
      : super(key: key);

  final String img;
  final String date;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: REdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff7090B0).withAlpha(40),
              offset: const Offset(0, 16),
              blurRadius: 40)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            width: 70.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            DateFormat.jm().format(DateTime.parse(date)),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
          Text(
            temp,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                fontFamily: 'Default'),
          ),
        ],
      ),
    );
  }
}
