import 'package:flutter/material.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:latest_weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:latest_weather_app/views/search_view.dart';
import 'package:latest_weather_app/widgets/noWeatherInfo.dart';
import 'package:latest_weather_app/widgets/weatherinfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 231, 206, 93),
                  const Color.fromARGB(255, 91, 92, 136), // Light purple
                ],
              ),
            ),
          ),
          title: const Text(
            'Weather App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchView();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),*/
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return WeatherInfoBody(
              weatherModel: state.weatherModel,
            );
          } else if (state is WeatherLoadingSta) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(
                'Oops, there was an error',
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            );
          }
        },
      ),
    );
  }
}
