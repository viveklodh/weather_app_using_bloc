import 'package:equatable/equatable.dart';
import '../../models/weather_model.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherIsLoadingState extends WeatherState {}

class WeatherIsLoadedState extends WeatherState {
  WeatherModel weatherModel;
  WeatherIsLoadedState(this.weatherModel);
  @override
  List<Object> get props => [weatherModel];
}

class WeatherErrorState extends WeatherState {}
