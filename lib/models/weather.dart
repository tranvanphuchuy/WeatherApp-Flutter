import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:weatherApp_rffrench/models/location.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

import 'daily_weather.dart';

//TODO: Handle exceptions in every part of the app
class Weather {
  String apiKey =
      DotEnv().env['APIKEY']; // API Key stored safely in a .env file
  String openWeatherURL = 'https://api.openweathermap.org/data/2.5/onecall';
  String tempUnit = 'metric';
  List<DailyWeather> dailyWeatherCards = [];
  var currentTempDouble; // var because when the weather is not double it will be an int. E.g: 9°C
  dynamic
      currentTemp; // dynamic because it will start as double and then will be casted to int
  var maxTempDouble;
  var minTempDouble;
  dynamic maxTemp;
  dynamic minTemp;
  int todayCondition = 999; // Icon will be N/A while loading
  dynamic todayEpoch;

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

  void getDailyWeather(dynamic weatherData) {
    List<dynamic> jsonDays = weatherData['daily']; // List of days from JSON
    jsonDays.forEach((day) {
      //Generating a DailyWeather instance for each day so later the widget cards can be created
      dailyWeatherCards.add(
        DailyWeather(
          weekday: kWeekdays[
              DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).weekday],
          conditionWeather: day['weather'][0]['id'],
          maxTemp:
              day['temp']['max'].round(), // dynamic data type. No need to cast
          minTemp: day['temp']['min'].round(),
        ),
      );
    });
  }

  void getTodayWeather(dynamic weatherData) {
    // * 1000 Because the API returns the epoch
    todayEpoch = DateTime.fromMillisecondsSinceEpoch(
        weatherData['current']['dt'] * 1000);

    currentTempDouble = weatherData['current']['temp'];
    currentTemp = double.parse((currentTempDouble)
        .toStringAsFixed(1)); // THis is not neccesary anymore
    currentTemp = currentTemp.round();

    maxTempDouble = weatherData['daily'][0]['temp']['max'];
    maxTemp = maxTempDouble.round();
    minTempDouble = weatherData['daily'][0]['temp']['min'];
    minTemp = minTempDouble.round();
    todayCondition = weatherData['current']['weather'][0]['id'];
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
