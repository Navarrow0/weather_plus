// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_response.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecastResponseEntity _$WeatherForecastResponseEntityFromJson(
        Map<String, dynamic> json) =>
    WeatherForecastResponseEntity(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              CurrentWeatherResponseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherForecastResponseEntityToJson(
        WeatherForecastResponseEntity instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
