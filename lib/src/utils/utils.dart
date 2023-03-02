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

enum FieldType { email, password, normal, date, phone, underLine, number }

enum ButtonType { flat, rounded, text, outlined, toggle, iconArrow }

enum AuthAction { done, doneLogout, doneDelete, editProfile, forgotPassword}

