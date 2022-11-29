import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_app_utilities/weather_app_location.dart';

const apiKey = '8b714106f1be574cfbbc90c4677da2be';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});
  late LocationIdentifier locationData;
  late double currentTemperature;
  late int currentCondition;
  //late String cityName;

  Future<void> getCurrentTemperature() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        //cityName = WeatherData(locationData: locationData) as String;
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
        if (currentCondition < 1000) {
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.cloud,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage('assets/cloudy.webp'),
          );
        } else {
          var now = DateTime.now();

          if (now.hour >= 15) {
            return WeatherDisplayData(
              weatherImage: const AssetImage('assets/night.webp'),
              weatherIcon: const Icon(
                FontAwesomeIcons.moon,
                size: 75.0,
                color: Colors.white,
              ),
            );
          } else {
            return WeatherDisplayData(
              weatherIcon: const Icon(
                FontAwesomeIcons.sun,
                size: 75.0,
                color: Colors.white,
              ),
              weatherImage: const AssetImage('assets/sunny.webp'),
            );
          }
        }
      }
    }