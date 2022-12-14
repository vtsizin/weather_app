import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../weather_app_main_screen.dart';
import '../weather_app_utilities/weather_app_location.dart';
import '../weather_app_utilities/weather_app_weatherAPI.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationIdentifier locationData;

  Future<void> getLocationData() async {
    locationData = LocationIdentifier();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // todo: Handle no location
    }
  }

  void getWeatherData() async {
    // Fetch the location
    await getLocationData();

    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen(
            weatherData: weatherData,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
         Center(
          child: SpinKitSpinningCircle(
            color: Colors.blueAccent,
            size: 100.0,
            duration: Duration(milliseconds: 1400),
          ),
        ),
      );
  }
}


