import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherApp_rffrench/models/location.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

class MainScreen extends StatefulWidget {
  static const String id = '/main_screen';
  final dynamic weatherData;

  MainScreen({this.weatherData});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String today = kWeekdays[DateTime.now().weekday.toInt()].substring(0, 3) +
      ', ' +
      DateTime.now().day.toString() +
      ' ' +
      kMonths[DateTime.now().month].substring(0, 3);

  double currentTempDouble;
  var currentTemp; // var because it will start as double and then will be casted to int
  String locality;
  String country;
  double maxTempDouble;
  double minTempDouble;
  var maxTemp;
  var minTemp;

  @override
  void initState() {
    super.initState();
    print(widget.weatherData);
    updateWeather(widget.weatherData);
  }

  Future<void> setLocationName() async {
    Placemark placemark = await Location()
        .getLocationName(); // Getting the location name by coordinates

    locality = placemark.locality;
    country = placemark.country;
    print('Locality: ' + placemark.locality);
    print('Country: ' + placemark.country);
  }

  void updateWeather(dynamic weatherData) async {
    if (weatherData == null) {
      currentTemp = 0;
    } else {
      await setLocationName(); // Must await or it will return null values in the UI
      setState(() {
        getTodayWeather(weatherData);
      });
    }
  }

  void getTodayWeather(dynamic weatherData) {
    currentTempDouble = weatherData['current']['temp'];
    currentTemp = double.parse((currentTempDouble)
        .toStringAsFixed(1)); // THis is not neccesary anymore
    currentTemp = currentTemp.round();
    maxTempDouble = weatherData['daily'][0]['temp']['max'];
    maxTemp = maxTempDouble.round();
    minTempDouble = weatherData['daily'][0]['temp']['min'];
    minTemp = minTempDouble.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontFamily: 'Dosis', fontSize: 22),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                print('search button');
              }),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Today',
                        style: TextStyle(
                            fontFamily: 'Dosis',
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        today,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                currentTemp.toString(),
                style: TextStyle(
                  fontSize: 70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  '°C',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '$locality, $country',
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Max: ${maxTemp.toString()}',
              ),
              SizedBox(width: 15),
              Text(
                '•',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: 15),
              Text(
                'Min: ${minTemp.toString()}',
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[Text('List View')],
            ),
          ),
        ],
      ),
    );
  }
}
