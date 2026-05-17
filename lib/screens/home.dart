import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/weather_images.dart';

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

  WeatherModel? weatherModel;

  int code = 0;

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

    code = weatherData['weather'][0]['id'];

    weatherModel = WeatherModel(
      description: weatherData['weather'][0]['description'],
      location: weatherData['name'] + ', ' + weatherData['sys']['country'],
      temperature: weatherData['main']['temp'],
      feelsLike: weatherData['main']['feels_like'],
      humidity: weatherData['main']['humidity'],
      wind: weatherData['wind']['speed'],
      icon:
          'images/weather_icons/${getIconPrefix(code)}${kWeatherIcons[code.toString()]!['icon']}.svg',
    );

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
        // backgroundColor: kOverlayColor,
        backgroundColor: Colors.black87,
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
                    Text(weatherModel!.location!, style: kLocationTextStyle),
                    SizedBox(height: 25),

                    SvgPicture.asset(
                      weatherModel!.icon!,
                      height: 180,
                      color: kLightColor
                    ),

                    SizedBox(height: 40),
                    Text(
                      '${weatherModel!.temperature!.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel!.description!.toUpperCase(),
                      style: kLocationTextStyle,
                    ),
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
                          DetailsWidget(
                            title: 'Feels Like',
                            value: '${weatherModel!.feelsLike!.round()}°',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: VerticalDivider(thickness: 1),
                          ),
                          DetailsWidget(
                            title: 'Humidity',
                            value: '${weatherModel!.humidity!}%',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: VerticalDivider(thickness: 1),
                          ),
                          DetailsWidget(
                            title: 'Wind',
                            value: '${weatherModel!.wind!.round()}',
                          ),
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
