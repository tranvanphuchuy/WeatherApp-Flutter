import 'package:flutter/material.dart';
import 'package:weatherApp_rffrench/models/weather.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

class DailyWeatherCard extends StatelessWidget {
  final String weekday;
  final int conditionWeather;
  final dynamic maxTemp;
  final dynamic minTemp;

  DailyWeatherCard(
      {@required this.weekday,
      @required this.conditionWeather,
      @required this.maxTemp,
      @required this.minTemp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWeatherCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  weekday,
                  style: kDailyCardStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Image(
                  image: Weather().getWeatherIcon(conditionWeather),
                  width: 20,
                  height: 20,
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${maxTemp.toString()} °C',
                    style: kDailyCardStyle,
                  ),
                  SizedBox(width: 15),
                  Text(
                    '${minTemp.toString()} °C',
                    style: kDailyCardStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
