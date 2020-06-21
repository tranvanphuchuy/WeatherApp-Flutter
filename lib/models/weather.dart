import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:weatherApp_rffrench/models/location.dart';

//TODO: Handle exceptions in every part of the app
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

  Future<dynamic> getNamedLocationWeather(String newLocation) async {
    Position position = await Location().getLocationCoordinates(newLocation);

    try {
      dynamic weatherData = await NetworkService().fetchAPI(
          '$openWeatherURL?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly,minutely&appid=$apiKey&units=$tempUnit');
      return weatherData;
    } catch (e) {
      print(e);
      //throw Exception('Error fetching API by named location');
    }
  }

// ICONS by: MeteoIcons. http://www.alessioatzeni.com/meteocons/

//TODO: Edit values. Add accuracy
  AssetImage getWeatherIcon(int condition) {
    if (condition < 300) {
      return AssetImage('images/thunderstorm.png');
    } else if (condition < 400) {
      return AssetImage('images/drizzle.png');
    } else if (condition < 600) {
      return AssetImage('images/rain.png');
    } else if (condition < 700) {
      return AssetImage('images/snow.png');
    } else if (condition < 800) {
      return AssetImage('images/mist.png');
    } else if (condition == 800) {
      return AssetImage('images/sunny.png');
    } else if (condition <= 804) {
      return AssetImage('images/clouds.png');
    } else {
      return AssetImage('images/none.png');
    }
  }
}
