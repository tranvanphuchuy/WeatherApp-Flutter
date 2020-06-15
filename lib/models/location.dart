import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

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

  Future<void> getCurrentLocation() async {
    // Void because there is no usable value in the Future. The usable values will be the fields of the class
    try {
      //checkLocationPermission();
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      );

      latitude = position.latitude; // they must be double
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }

  Future<Placemark> getLocationName() async {
    Location location = Location();
    await location
        .getCurrentLocation(); // Saving lat and lon in the location object

    List<Placemark> placemarksList = await Geolocator()
        .placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark placemark = placemarksList.first; // Returns a list of Placemarks
    return placemark;
  }
}
