import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GeolocatorPlatform geoLocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=34.53&lon=69.12&appid=7c0f760c846e6cbcdc56299315d94739&units=metric"
        ""));

    if(response.statusCode == 200) {
      String data = response.body;
      print(data);
      var main = jsonDecode(data)['weather'][0]['main'];
      var cityName = jsonDecode(data)['name'];
      var feelsLike = jsonDecode(data)['main']['feels_like'];
      print('Weather Condition: $main');
      print('City Name: $cityName');
      print('Feels Like: $feelsLike');
    }else {
      print(response.statusCode);
    }
  }

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
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
