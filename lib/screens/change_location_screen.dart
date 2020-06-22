import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

class ChangeLocationScreen extends StatefulWidget {
  final Function changeLocationCallback;

  ChangeLocationScreen({@required this.changeLocationCallback});

  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  bool isLoading =
      false; // Variable that will be used to tell if something is being loaded

  Widget _setLoadingIcon() {
    // This method will make a loading icon visible if the user taps on the button
    Widget loadingIcon;
    setState(() {
      if (isLoading) {
        loadingIcon = Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              color: Colors.white,
            ));
      } else {
        loadingIcon = null;
      }
    });
    return loadingIcon;
  }

  @override
  Widget build(BuildContext context) {
    String locationName;

    return Container(
      // First container which is invisible
      color: kPrimaryBlueColor,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: kPrimaryBlueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text('Enter the new location name:'),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 20),
              child: TextField(
                cursorColor: Colors.white,
                controller: _textFieldController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(color: Colors.white, fontFamily: 'Dosis'),
                onChanged: (newLocation) {
                  locationName = newLocation;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: _setLoadingIcon(),
                  suffixIconConstraints: BoxConstraints(maxHeight: 15),
                  filled: true,
                  fillColor: kWeatherCardColor,
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(80),
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              color: kButtonBlueColor,
              elevation: 10,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textColor: Colors.white,
              child: Text(
                'Change Location',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                locationName != null
                    ? setState(() {
                        isLoading = true;
                        widget.changeLocationCallback(locationName);
                      })
                    : print('null');
              },
            ),
          ],
        ),
      ),
    );
  }
}
