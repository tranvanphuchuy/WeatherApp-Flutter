import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:weatherApp_rffrench/models/location.dart';

class Weather {
  String apiKey =
      DotEnv().env['APIKEY']; // API Key stored safely in a .env file
  String openWeatherURL = 'https://api.openweathermap.org/data/2.5/onecall';
  String tempUnit = 'metric';

  Future<dynamic> getCurrentLocationWeather() async {
    Location location = Location();
    await location
        .getCurrentLocation(); // waits for the location of the device without storing it in a variable because it will store the coordinates inside the class

    try {
      dynamic weatherData = await NetworkService().fetchAPI(
          '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&appid=$apiKey&units=$tempUnit');
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
