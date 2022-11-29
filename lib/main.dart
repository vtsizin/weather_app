import 'package:flutter/material.dart';
import 'package:weather_app/weather_app_main_screen.dart';
import 'package:weather_app/weather_app_widgets/weather_app_loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.light(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoadingScreen(),
    );
  }
}
