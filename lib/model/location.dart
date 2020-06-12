import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  final String latitude;
  final String longitude;

  Location(
      [this.latitude, this.longitude]); // [ positional OPTIONAL parameters ]

  Future<void> checkLocationPermission() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (geolocationStatus != GeolocationStatus.granted) {
      throw Exception('Location disabled or not available. Please turn it on');
    } else {
      print(geolocationStatus);
    }
  }

  Future<void> getLocation() async {
    // Void because there is no usable value in the Future. The usable values will be the fields of the class
    try {
      //checkLocationPermission();
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      );

      var latitude = position.latitude;
      var longitude = position.longitude;
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }
}
