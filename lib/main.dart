import 'package:bloc_example/Services/weather_service.dart';
import 'package:bloc_example/bloc/weather_bloc/weather_bloc.dart';
import 'package:bloc_example/pages/weather_home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(WeatherService()),
        ),
      ],
      child: WeatherHomePage(),
    ));
  }
}
