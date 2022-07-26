import 'package:flutter/material.dart';
import 'package:weather_app/components/hourly_weather_card.dart';

class HourlyWeather extends StatefulWidget {
  @override
  createState() => _hourlyWeatherState();
}

class _hourlyWeatherState extends State {
  List<dynamic> hourlyWeather = ['09:00', '10:00', '11:00', '09:00', '10:00', '11:00', '09:00', '10:00', '11:00', '09:00', '10:00', '11:00'];

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          for(var item in hourlyWeather) HourlyWeatherCard()
        ],
      ),
    );
  }
}