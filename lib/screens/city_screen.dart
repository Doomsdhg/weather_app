import 'package:flutter/material.dart';
import 'package:weather_app/components/current_weather_block.dart';
import 'package:weather_app/components/forecast_block.dart';

class CityScreen extends StatefulWidget {
  late String cityName;

  CityScreen({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _cityScreenState(cityName: cityName);
}

class _cityScreenState extends State {
  late String cityName;

  _cityScreenState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$cityName weather'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(20),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    CurrentWeatherBlock(),
                    ForecastBlock(cityName: cityName,)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
