import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GeolocatorPlatform geoLocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;
  void getPermission() async {
    permission = await geoLocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      print('Permission Denied');
      permission = await geoLocatorPlatform.requestPermission();

      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          print(
            'Permission permenantly denied, please provide permission to the app from the setting.',
          );
        } else {
          print('Permission granted');
          getLocation();
        }
      } else {
        print('User denied the request.');
      }
    } else {
      getLocation();
    }
  }

  void getLocation() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              getPermission();
            },
            child: const Text('Get Location', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
