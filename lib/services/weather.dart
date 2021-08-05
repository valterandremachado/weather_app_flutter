import 'package:weather_app/utilities/constants.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper service = NetworkHelper(url);
    var weatherData = await service.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelper service = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric');

    var weatherData = await service.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for 🩳 and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
