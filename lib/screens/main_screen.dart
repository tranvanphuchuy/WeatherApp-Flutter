import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_indicator/loading_indicator.dart';
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

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading =
      false; // Variable that will be used to tell if something is being loaded
  String locality;
  String country;
  Weather weather = Weather();
  String todayString =
      kWeekdays[DateTime.now().weekday.toInt()].substring(0, 3) +
          ', ' +
          DateTime.now().day.toString() +
          ' ' +
          kMonths[DateTime.now().month].substring(0, 3);

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
      weather.currentTemp = 0;
      weather.maxTemp = 0;
      weather.minTemp = 0;
      locality = '';
      country = '';
      weather.dailyWeatherCards.clear();
    } else {
      await setLocationName(
          newLocation); // Must await or it will return null values in the UI
      weather.dailyWeatherCards.clear();
      setState(() {
        weather.getTodayWeather(weatherData); // Current and today's weather
        weather.getDailyWeather(weatherData); // Daily forecast
      });
    }
    isLoading = false;
  }

  Future<void> setLocationName(String newLocation) async {
    Placemark placemark = await Location().getLocationName(
        newLocation); // Getting the location name by coordinates

    locality = placemark.locality;
    country = placemark.country;
    print('Locality: ' + placemark.locality);
    print('Country: ' + placemark.country);
  }

  Widget _setLoadingIcon() {
    // This method will make a loading icon visible if the user taps on the button
    Widget loadingIcon;
    setState(() {
      if (isLoading) {
        loadingIcon = LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          color: Colors.white,
        );
      } else {
        loadingIcon = null;
      }
    });
    return loadingIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
            style: TextStyle(fontFamily: 'Dosis', fontSize: 22),
          ),
          leading: IconButton(
            icon: Icon(Icons.near_me),
            color: Colors.white,
            onPressed: () async {
              setState(() {
                // Set state first so the loading icon can be shown
                isLoading = true;
              });
              // Returning the current location weather
              dynamic newWeatherData =
                  await weather.getCurrentLocationWeather();
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
                            dynamic newWeatherData = await weather
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
              padding: EdgeInsets.only(
                top: 5,
                right: 10,
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                width: 10,
                height: 10,
                child: _setLoadingIcon(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: weather.getWeatherIcon(weather.todayCondition),
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
                  weather.currentTemp.toString(),
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
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${weather.maxTemp.toString()}°C',
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
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${weather.minTemp.toString()}°C',
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
              itemCount: weather.dailyWeatherCards.length,
              itemBuilder: (context, index) {
                // Creating the cards
                return DailyWeatherCard(
                    weekday: weather.dailyWeatherCards[index].weekday,
                    conditionWeather:
                        weather.dailyWeatherCards[index].conditionWeather,
                    maxTemp: weather.dailyWeatherCards[index].maxTemp,
                    minTemp: weather.dailyWeatherCards[index].minTemp);
              },
            ),
          ],
        ),
      ),
    );
  }
}
