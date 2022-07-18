import 'package:bloc_example/Services/weather_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/weather_bloc/weather_bloc.dart';
import '../bloc/weather_bloc/weather_event.dart';
import '../bloc/weather_bloc/weather_state.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is WeatherIsLoadedState) {
          Fluttertoast.showToast(msg: "weather is loaded");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 300,
                  width: 300,
                  child: FlareActor(
                    "assets/WorldSpin.flr",
                    fit: BoxFit.fill,
                    animation: "roll",
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitialState) {
                      return Column(
                        children: [
                          TextField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter City',
                              hintText: 'Enter City',
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context).add(
                                    FetchWeatherEvent(cityController.text));
                                cityController.clear();
                              },
                              child: const Text("Search"))
                        ],
                      );
                    } else if (state is WeatherIsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WeatherIsLoadedState) {
                      return Column(
                        children: [
                          Text(
                              "weather of : ${state.weatherModel.name.toString()}"),
                          Text(
                              "pressure: ${state.weatherModel.main!.pressure.toString()}"),
                          Text(
                              "temp: ${state.weatherModel.main!.temp.toString()}"),
                          Text(
                              "minTemp: ${state.weatherModel.main!.tempMin.toString()}"),
                          Text(
                              "maxTamp: ${state.weatherModel.main!.tempMax.toString()}"),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context)
                                    .add(ResetWeatherEvent());
                              },
                              child: Text("reset"))
                        ],
                      );
                    }
                    return Text("error");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
