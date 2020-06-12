import 'package:flutter/material.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlueColor,
      body: Container(
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
    );
  }
}
