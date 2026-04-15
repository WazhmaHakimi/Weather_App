import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude, longitude;

  Future<void> getCurrentLocation() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 100,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    latitude = position.latitude;
    longitude = position.longitude;
  }
}
