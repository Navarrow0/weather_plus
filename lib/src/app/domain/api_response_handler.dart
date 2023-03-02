import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';



class ResponseHandler {
  static Result<T, String> handle<T>(Response<dynamic> response, T Function(dynamic json) fromJson) {
    if (response.statusCode == 200) {
      return Success(fromJson(response.data));
    } else if (response.statusCode == 400) {
      final firstErrorMessage = response.data['message'];
      return Error(firstErrorMessage);
    } else {
      final errorMessage = response.data['message'];
      return Error(errorMessage);
    }
  }
}