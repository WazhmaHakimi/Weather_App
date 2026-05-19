import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class Weather {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
      "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric",
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      "$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric",
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }
}
