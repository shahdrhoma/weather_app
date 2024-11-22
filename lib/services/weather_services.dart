import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latest_weather_app/models/weather_model.dart';

class WeatherServices {
  WeatherServices(this.dio);
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final Dio dio;

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      log(response.data.toString());
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      String errorMessage = 'oops there was an error';

      if (e.response != null && e.response?.data != null) {
        if (e.response?.data['error'] != null &&
            e.response?.data['error']['message'] != null) {
          errorMessage = e.response?.data['error']['message'];
        }
      }
      log('DioException: $errorMessage');
      print('API Key: $apiKey');

      throw Exception(errorMessage);
    }
  }
}
