
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:momentum/momentum.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_plus/src/app/data/entities/current_weather_response.entity.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'package:weather_plus/src/app/data/entities/weather_forecast_response.entity.dart';
import 'package:weather_plus/src/app/data/services/weather_service.dart';
import 'package:weather_plus/src/utils/toast.dart';
import 'package:weather_plus/src/utils/utils.dart';
import 'home.model.dart';

class HomeController extends MomentumController<HomeModel>{

  late WeatherService weatherService;

  @override
  HomeModel init() {
    weatherService = service<WeatherService>();
    _determinePosition();
    return HomeModel(this, timeParametersEntity: TimeParametersEntity());
  }

  Future<Result<CurrentWeatherResponseEntity, String>> getCurrentWeather() async {
    return await weatherService.getCurrentWeather(timeParametersEntity: model.timeParametersEntity!);
  }

  Future<Result<WeatherForecastResponseEntity, String>> getWeatherPerHour() async {
    return await weatherService.getWeatherPerHour(timeParametersEntity: model.timeParametersEntity!);
  }

  updateWeather({ Units? units}) {
    getCurrentWeather();
    model.update(timeParametersEntity: TimeParametersEntity(lat: model.timeParametersEntity!.lat, lon: model.timeParametersEntity!.lon, units: units == Units.IMPERIAL ? 'imperial' : units == Units.METRIC ? 'metric' : 'metric'  ));
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMessage('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showMessage('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showMessage('Location permissions are permanently denied, we cannot request permissions.');
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    model.update(timeParametersEntity: TimeParametersEntity(lat: position.latitude, lon: position.longitude));
    updateWeather();
  }


}