import 'package:flutter/material.dart';
import 'package:weatherApp_rffrench/utilities/constants.dart';

class ChangeLocationScreen extends StatelessWidget {
  final Function changeLocationCallback;
  TextEditingController _textFieldController = TextEditingController();

  ChangeLocationScreen({@required this.changeLocationCallback});

  @override
  Widget build(BuildContext context) {
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
            Text('Enter the location name'),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 5),
              child: TextField(
                cursorColor: Colors.white,
                controller: _textFieldController,
                autofocus: true,
                maxLength: 40,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(color: Colors.white, fontFamily: 'Dosis'),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
