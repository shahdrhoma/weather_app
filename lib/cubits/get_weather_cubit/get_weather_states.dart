import 'package:latest_weather_app/models/weather_model.dart';

class WeatherState {}

class InitialState extends WeatherState {}

class WeatherLoadingSta extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoadedState(this.weatherModel);
}

class WeatherFailureState extends WeatherState {
  final String errorMessage;

  WeatherFailureState(this.errorMessage);
}
