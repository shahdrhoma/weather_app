import 'package:flutter/material.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:latest_weather_app/views/welcome_view.dart';
import 'views/homeview.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          final color = getWeatherColor(state is WeatherLoadedState
              ? state.weatherModel.weatherCondition
              : null);
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: color,
              appBarTheme: AppBarTheme(backgroundColor: color),
              primaryColor: color,
              primarySwatch:
                  _createMaterialColor(color), // Use a MaterialColor here
              // Additional customization for light theme can go here
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(backgroundColor: Colors.black),
              primaryColor: Colors.white,
              primarySwatch: Colors.blueGrey,
              // Additional customization for dark theme can go here
            ),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const WelcomeView(),
          );
        },
      ),
    );
  }
}

// Function to create MaterialColor from a Color
MaterialColor _createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = {};
  for (int i = 0; i < 10; i++) {
    final strength = strengths[i];
    swatch[strength] = color.withOpacity(1.0 - i * 0.1);
  }
  return MaterialColor(color.value, swatch);
}

// Update getWeatherColor to return Color (MaterialColor can be generated from it)
MaterialColor getWeatherColor(String? condition) {
  if (condition == null) return Colors.grey;
  switch (condition) {
    case "Sunny":
      return Colors.amber; // A soft, warm yellow
    case "Clear":
      return Colors.lightBlue; // A calm, soft blue
    case "Partly cloudy":
    case "Cloudy":
      return Colors.blueGrey; // Muted grey-blue
    case "Overcast":
    case "Mist":
    case "Light rain":
      return Colors.cyan; // Soft cyan, calm blue-green
    case "Patchy rain possible":
    case "Moderate rain":
      return Colors.teal; // Calming teal color
    case "Heavy rain":
      return Colors.indigo; // Slightly deeper blue
    case "Blowing snow":
    case "Blizzard":
    case "Heavy snow":
    case "Partly cloudy":
    case "Fog":
    case "Freezing fog":
      return Colors.blueGrey; // Softer grey-blue for snow or fog
    case "Light drizzle":
    // Soft green for light drizzle
    case "Moderate rain at times":
    case "Heavy rain at times":
      return Colors.lightBlue; // Calm light blue for intermittent rain
    case "Patchy snow possible":
    case "Patchy sleet possible":
      return Colors.grey; // Neutral grey for light snow/sleet
    case "Light freezing rain":
      return Colors.blue; // Light blue for freezing rain
    case "Moderate or heavy freezing rain":
    case "Ice pellets":
    case "Light showers of ice pellets":
    case "Patchy light snow":
    case "Light snow":
    case "Moderate snow":
    case "Heavy freezing drizzle":
    // Soft pink for light snow or drizzle
    case "Torrential rain shower":
    case "Light rain shower":
    case "Moderate or heavy rain shower":
      return Colors.blueGrey; // Muted, cooler tone for rain showers
    default:
      return Colors.blueGrey; // Default to a calm blue-grey
  }
}
