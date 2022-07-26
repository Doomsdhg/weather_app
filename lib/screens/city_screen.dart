import 'package:flutter/material.dart';
import 'package:weather_app/components/current_weather_block.dart';
import 'package:weather_app/components/forecast_block.dart';

class CityScreen extends StatefulWidget {
  late String name;

  CityScreen({required String name}) {
    this.name = name;
  }

  @override
  createState() => _cityScreenState(name: name);
}

class _cityScreenState extends State {
  late String name;

  _cityScreenState({required String name}) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name weather'),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: ColoredBox(
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  CurrentWeatherBlock(),
                  ForecastBlock()
                ],
              ),
            ),
          )),
    );
  }
}
