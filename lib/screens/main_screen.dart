import 'package:flutter/material.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.weatherData);
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
      body: Column(),
    );
  }
}
