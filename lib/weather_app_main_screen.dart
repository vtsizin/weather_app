import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weather_app_utilities/weather_app_weatherAPI.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  //late String cityName;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
      weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      //cityName = weatherData.cityName;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15.0,
            ),
            //Text(cityName),
            Center(
              child: Text(
                ' $temperature°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
