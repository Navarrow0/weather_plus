import 'package:dio/dio.dart';
import 'package:weather_plus/src/utils/utils.dart';

import 'errors.dart';

class Api {
  final dio = createDio();
  Api._internal();

  static final _singleton = Api._internal();

  factory Api({String? baseUrl}) => _singleton..dio.options.baseUrl = baseUrl ?? Utils.urlApi;

  static Dio createDio({String? baseUrl}) {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? Utils.urlApi,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
      contentType: 'application/json; charset=UTF-8',
      headers: {
        'Accept' : 'application/json',
      },
      receiveDataWhenStatusError: true,
        validateStatus: (_)=> true
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}


