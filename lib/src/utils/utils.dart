import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static String urlApi = dotenv.env['API_BASE']!;
  static String urlGeoApi = dotenv.env['API_GEO_BASE']!;
}

/**
 * Fahrenheit = imperial
 * Celsius = metric
 **/
enum Units { METRIC, IMPERIAL }

extension WeatherUnits on Units {
  String get unit {
    switch (this) {
      case Units.METRIC:
        return 'metric';
      case Units.IMPERIAL:
        return 'imperial';
      default:
        return 'metric';
    }
  }
}