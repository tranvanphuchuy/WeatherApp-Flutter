import 'package:weatherApp_rffrench/services/networking.dart';
import 'package:geolocator/geolocator.dart';

//TODO: Fix location permission bugs
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

  // This method will return the location name based on coordinates. Even if a new location is added this method will be called because it will return the locality and the country thus making the location string more appealing.
  Future<Placemark> getLocationName(String newLocation) async {
    Location location = Location();
    Position position;
    if (newLocation == null) {
      // Checks if the call is from a newLocation or if it is the currentLocation
      try {
        await location
            .getCurrentLocation(); // Saving lat and lon in the location object

        List<Placemark> placemarksList = await Geolocator()
            .placemarkFromCoordinates(location.latitude,
                location.longitude); // Returns a list of Placemarks
        Placemark placemark = placemarksList.first;
        return placemark;
      } catch (e) {
        print(e);
      }
    } else {
      // This means that new Location is not empty
      try {
        position = await Location().getLocationCoordinates(newLocation);
        List<Placemark> placemarksList = await Geolocator()
            .placemarkFromCoordinates(position.latitude,
                position.longitude); // Returns a list of Placemarks
        Placemark placemark = placemarksList.first;
        return placemark;
      } catch (e) {
        print(e);
      }
    }
  }

  // This method returns the coordinates of a Location typed by a user
  Future<Position> getLocationCoordinates(String newLocation) async {
    List<Placemark> placemarksList;
    try {
      placemarksList = await Geolocator().placemarkFromAddress(newLocation);
      Placemark placemark = placemarksList.first;
      Position position = placemark.position;
      return position;
    } catch (e) {
      print(e);
      //throw Exception('Location name does not exist');
    }
  }
}
