import 'package:hive/hive.dart';
import 'package:momentum/momentum.dart';
import 'package:weather_plus/src/app/data/entities/current_weather_response.entity.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'package:weather_plus/src/app/data/entities/weather_forecast_response.entity.dart';
import 'package:weather_plus/src/app/domain/api.dart';
import 'package:weather_plus/src/app/domain/api_response_handler.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_plus/src/utils/utils.dart';

class WeatherService extends MomentumService {
  static WeatherService? _instance;

  factory WeatherService() => _instance ??= WeatherService._();

  WeatherService._();


  Future<Result<CurrentWeatherResponseEntity, String>> getCurrentWeather({required TimeParametersEntity timeParametersEntity}) async {
    final response = await Api().dio.get('weather', queryParameters: timeParametersEntity.toJson());
    final result = ResponseHandler.handle(response, (json) => CurrentWeatherResponseEntity.fromJson(json));
    return result;
  }

  Future<Result<WeatherForecastResponseEntity, String>> getWeatherPerHour({required TimeParametersEntity timeParametersEntity}) async {
    final response = await Api().dio.get('forecast', queryParameters: timeParametersEntity.toJson());
    final result = ResponseHandler.handle(response, (json) => WeatherForecastResponseEntity.fromJson(json));
    return result;
  }

  Future<Result<List<LocationEntity>, String>> getCountrys({required TimeParametersEntity timeParametersEntity}) async {
    final response = await Api(baseUrl: Utils.urlGeoApi).dio.get('direct', queryParameters: timeParametersEntity.toJson());
    final result = ResponseHandler.handle(response, (json) => (response.data as List)
        .map((p) => LocationEntity.fromJson(p))
        .toList());
    return result;
  }

  Future<List<LocationEntity>> getFavorites() async {
    Box<LocationEntity> box = await Hive.openBox<LocationEntity>('favorites');
    return box.values.toList();
  }
}
