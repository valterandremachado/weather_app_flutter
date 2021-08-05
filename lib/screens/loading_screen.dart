import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    // Equivalent to viewDidLoad
    // TODO: implement initState
    super.initState();
    getUserLocationWithWeatherData();
  }

  @override
  void deactivate() {
    // Equivalent to viewDidDisappear
    // TODO: implement deactivate
    super.deactivate();
  }

  void getUserLocationWithWeatherData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData: weatherData);
    }));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
