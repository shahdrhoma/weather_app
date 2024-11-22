import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:latest_weather_app/models/weather_model.dart';

class WeatherServices {
  WeatherServices(this.dio);
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '30f57fdf900545e999f91535242211';
  final Dio dio;

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      log(response.data.toString());
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      //we use this check if we used http package not dio package
      /* if (response.statusCode == 201) { 
        WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      } else {
        final String messageError= response.data['error']['message'];
        throw Exception(messageError);
      }*/
      return weatherModel;
    } on DioException catch (e) {
      // handling for dio exceptions onlyyyy
      /*  final String errorMessage =
          e.response?.data['error']['message'] ?? 'oops there was an error';
      throw Exception(errorMessage);*/
      String errorMessage = 'oops there was an error';

      if (e.response != null && e.response?.data != null) {
        if (e.response?.data['error'] != null &&
            e.response?.data['error']['message'] != null) {
          errorMessage = e.response?.data['error']['message'];
        }
      }
      log('DioException: $errorMessage'); // Log the error for debugging
      throw Exception(errorMessage);
    } /*catch (e) {
      // log(e.toString());
      log('General exception: $e');
      throw Exception('oops there was an error');
    }*/
  }
}
