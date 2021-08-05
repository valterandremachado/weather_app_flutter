import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  late int temperature;
  late int condition;
  late String cityName;
  late String weatherIcon;
  late String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.weatherData);
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get data';
        cityName = '';
        return;
      }

      double temp = data['main']['temp'];
      temperature = temp.toInt();
      var condition = data['weather'][0]['id'];
      cityName = data['name'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedCityName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedCityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

