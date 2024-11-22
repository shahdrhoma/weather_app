import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_states.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFEF5DA),
                  Color(0xFF3C4756),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            'Search Your City',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocConsumer<GetWeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoadedState) {
            // Go back to HomeView once data is fetched
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is WeatherLoadingSta) {
            // Show loading indicator while fetching data
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFEF5DA),
                  Color(0xFF323E4F),
                ],
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter a city name to check the weather',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.15),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelText: 'Search',
                        labelStyle: const TextStyle(color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          onPressed: () {
                            // Trigger weather fetch
                            var getWeatherCubit =
                                BlocProvider.of<GetWeatherCubit>(context);
                            getWeatherCubit.getWeather(
                                cityName: controller.text);
                          },
                        ),
                      ),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
