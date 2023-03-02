import 'package:momentum/momentum.dart';
import 'package:weather_plus/src/app/data/services/weather_service.dart';
import 'favorite.model.dart';

class FavoriteController extends MomentumController<FavoriteModel> {

  late WeatherService weatherService;

  @override
  FavoriteModel init() {
    weatherService = service<WeatherService>();
    return FavoriteModel(this,);
  }

}
