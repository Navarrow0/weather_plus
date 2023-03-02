import 'package:momentum/momentum.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'package:weather_plus/src/app/data/services/weather_service.dart';
import 'location.model.dart';

class LocationController extends MomentumController<LocationModel> {
  late WeatherService weatherService;

  Future<Result<List<LocationEntity>, String>>? searchLocation;

  @override
  LocationModel init() {
    weatherService = service<WeatherService>();
    return LocationModel(this, timeParametersEntity: TimeParametersEntity());
  }



  void updateFuture() {
    searchLocation = weatherService.getCountrys(timeParametersEntity: model.timeParametersEntity!,);
    model.update();
  }
}
