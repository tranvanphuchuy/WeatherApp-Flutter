import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherApp_rffrench/models/daily_weather.dart';
import 'package:weatherApp_rffrench/models/location.dart';
import 'package:weatherApp_rffrench/models/weather.dart';
import 'package:weatherApp_rffrench/screens/change_location_screen.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';
import 'package:weatherApp_rffrench/widgets/daily_weather_card.dart';

//TODO: Disable back button to loading screen
class MainScreen extends StatefulWidget {
  static const String id = '/main_screen';
  final dynamic weatherData;

  MainScreen({this.weatherData});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  dynamic todayEpoch;
  String todayString =
      kWeekdays[DateTime.now().weekday.toInt()].substring(0, 3) +
          ', ' +
          DateTime.now().day.toString() +
          ' ' +
          kMonths[DateTime.now().month].substring(0, 3);

  var currentTempDouble; // var because when the weather is not double it will be an int. E.g: 9°C
  dynamic
      currentTemp; // dynamic because it will start as double and then will be casted to int
  String locality;
  String country;
  var maxTempDouble;
  var minTempDouble;
  dynamic maxTemp;
  dynamic minTemp;
  int todayCondition = 999; // Icon will be N/A while loading
  List<DailyWeather> dailyWeatherCards = [];

  @override
  void initState() {
    updateWeather(
        widget.weatherData, null); // The second argument is a new location.
    super.initState();
    print(widget.weatherData);
  }

  void updateWeather(dynamic weatherData, String newLocation) async {
    //TODO: Change this and code exceptions
    if (weatherData == null) {
      currentTemp = 0;
      maxTemp = 0;
      minTemp = 0;
      locality = '';
      country = '';
      dailyWeatherCards.clear();
    } else {
      await setLocationName(
          newLocation); // Must await or it will return null values in the UI
      dailyWeatherCards.clear();
      setState(() {
        getTodayWeather(weatherData); // Current and today's weather
        getDailyWeather(weatherData); // Daily forecast
      });
    }
  }

  Future<void> setLocationName(String newLocation) async {
    Placemark placemark = await Location().getLocationName(
        newLocation); // Getting the location name by coordinates

    locality = placemark.locality;
    country = placemark.country;
    print('Locality: ' + placemark.locality);
    print('Country: ' + placemark.country);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontFamily: 'Dosis', fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(Icons.near_me),
          color: Colors.white,
          onPressed: () async {
            // Returning the current location weather
            dynamic newWeatherData =
                await Weather().getCurrentLocationWeather();
            setState(() {
              updateWeather(newWeatherData, null);
            });
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ChangeLocationScreen(
                        changeLocationCallback: (String newLocation) async {
                          dynamic newWeatherData = await Weather()
                              .getNamedLocationWeather(newLocation);
                          setState(() {
                            updateWeather(newWeatherData, newLocation);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              }),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: Weather().getWeatherIcon(todayCondition),
                    width: 35,
                    height: 35,
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
                        todayString,
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
          Center(
            child: Text(
              '$locality, $country',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${maxTemp.toString()}°C',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Text(
                '•',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(width: 18),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${minTemp.toString()}°C',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true, // needed because its inside another ListView
            physics: ClampingScrollPhysics(), // same
            itemCount: dailyWeatherCards.length,
            itemBuilder: (context, index) {
              // Creating the cards
              return DailyWeatherCard(
                  weekday: dailyWeatherCards[index].weekday,
                  conditionWeather: dailyWeatherCards[index].conditionWeather,
                  maxTemp: dailyWeatherCards[index].maxTemp,
                  minTemp: dailyWeatherCards[index].minTemp);
            },
          ),
        ],
      ),
    );
  }
}
