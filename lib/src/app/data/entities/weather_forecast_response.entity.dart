import 'package:json_annotation/json_annotation.dart';

import 'current_weather_response.entity.dart';
part 'weather_forecast_response.entity.g.dart';

@JsonSerializable()
class WeatherForecastResponseEntity {
  List<CurrentWeatherResponseEntity> list;

  WeatherForecastResponseEntity({required this.list});

  factory WeatherForecastResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastResponseEntityToJson(this);
}
