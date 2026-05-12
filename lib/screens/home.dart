import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

import 'package:weather_app/utilities/constants.dart';

import '../components/details_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? isDataLoaded = false;

  double? latitude, longitude;

  GeolocatorPlatform geoLocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    getPermission();
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

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric",
    );

    var weatherData = await networkHelper.getData();

    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded!) {
      return LoadingWidget();
    } else {
      return Scaffold(
        backgroundColor: kOverlayColor,
        body: SafeArea(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          decoration: kTextFieldDecoration,
                          onSubmitted: (String TypedName) {
                            print(TypedName);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white12,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('My Location', style: kTextFieldTextStyle),
                              SizedBox(width: 8),
                              Icon(Icons.gps_fixed, color: Colors.white60),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_city),
                    SizedBox(width: 12),
                    Text('City Name', style: kLocationTextStyle),
                    SizedBox(height: 25),

                    Icon(Icons.wb_sunny_outlined, size: 180),

                    SizedBox(height: 40),
                    Text('00°', style: kTempTextStyle),
                    Text('Clear', style: kLocationTextStyle),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: kOverlayColor,
                    child: Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DetailsWidget(title: 'Feels Like', value: '31°'),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: VerticalDivider(thickness: 1),
                          ),
                          DetailsWidget(title: 'Humidity', value: '15%'),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: VerticalDivider(thickness: 1),
                          ),
                          DetailsWidget(title: 'Wind', value: '7'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

// var id = decodedData['weather'][0]['id'];
// var temprature = decodedData['main']['temp'];
// var cityName = decodedData['name'];
