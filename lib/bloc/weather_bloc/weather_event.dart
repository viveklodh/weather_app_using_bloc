import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  String city;
  FetchWeatherEvent(this.city);
  @override
  List<Object?> get props => [city];
}

class ResetWeatherEvent extends WeatherEvent {}
