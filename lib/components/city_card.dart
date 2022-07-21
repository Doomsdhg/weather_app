import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class CityCard extends StatefulWidget {

  late String name;

  CityCard(String name){
    this.name = name;
  }

  @override
  _CityCardState createState() => _CityCardState(this.name);
}

class _CityCardState extends State {

  late String name;
  int? temperature;

  _CityCardState(String name){
    this.name = name;
  }

  Widget build(BuildContext context){
    _getCurrentTemperature();
    return Card(
      child: Container(
        child: Row(
          children: [
            Text(
                '$name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
            ),
            Container(
              child: Text(
                  '$temperature°C',
                  style: TextStyle(
                    fontSize: 30
                ),
              ),
              margin: EdgeInsets.only(left: 20),
            )
          ],
        ),
        padding: EdgeInsets.all(20),
      )
    );
  }

  void _getCurrentTemperature() async {
    final currentTemperature = await WeatherApi().getCurrentWeather(name);
    setState((){
      temperature = currentTemperature;
    });
  }
}
