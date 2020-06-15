import 'package:flutter/material.dart';
import 'package:weatherApp_rffrench/screens/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherApp_rffrench/screens/main_screen.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

void main() async {
  await DotEnv().load('.env'); // This loads the environment variables
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryBlueColor,
        scaffoldBackgroundColor: kPrimaryBlueColor,
        textTheme: TextTheme(
            bodyText2:
                TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
      ),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
