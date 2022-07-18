import 'package:bloc_example/Services/weather_service.dart';
import 'package:bloc_example/bloc/weather_bloc/weather_event.dart';
import 'package:bloc_example/bloc/weather_bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherService weatherService;
  WeatherBloc(this.weatherService) : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherIsLoadingState());

      try {
        WeatherModel weatherModel = await weatherService.getWeather(event.city);
        emit(WeatherIsLoadedState(weatherModel));
      } catch (e) {
        emit(WeatherErrorState());
      }
    });
    on<ResetWeatherEvent>((event, emit) async {
      emit(WeatherInitialState());
    });
  }
}
