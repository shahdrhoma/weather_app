import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:latest_weather_app/models/weather_model.dart';
import 'package:latest_weather_app/services/weather_services.dart';
import 'package:latest_weather_app/views/search_view.dart';

class WeatherLoadingState extends WeatherState {}

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(InitialState());
  getWeather({required String cityName}) async {
    emit(WeatherLoadingState()); // Emit the loading state
    try {
      WeatherModel weatherModel =
          await WeatherServices(Dio()).getCurrentWeather(cityName: cityName);
      emit(WeatherLoadedState(weatherModel)); // Emit success state
    } catch (e) {
      emit(WeatherFailureState(e.toString())); // Emit failure state
    }
  }
}
