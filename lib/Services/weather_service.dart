import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2";
    final result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      final jsonDecoded = json.decode(result.body);

      return WeatherModel.fromJson(jsonDecoded);
    }
    throw Exception();
  }
}
