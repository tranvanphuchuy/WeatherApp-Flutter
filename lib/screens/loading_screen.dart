import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherApp_rffrench/models/location.dart';
import 'package:weatherApp_rffrench/models/weather.dart';
import 'package:weatherApp_rffrench/screens/main_screen.dart';
import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = '/loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await Weather().getCurrentLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBlueColor,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Center(
                child: Container(
                  // Loading icon will be 1/4 of the width
                  width: MediaQuery.of(context).size.width / 4,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballScaleRippleMultiple,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image(
                      image: AssetImage('images/github.png'),
                      width: 22,
                      height: 22,
                    ),
                  ),
                  Text('Rffrench',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Dosis',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
