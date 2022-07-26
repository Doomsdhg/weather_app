import 'package:flutter/material.dart';
import 'package:weather_app/components/daily_weather_card.dart';

class DailyWeather extends StatefulWidget {
  @override
  createState() => _dailyWeatherState();
}

class _dailyWeatherState extends State {
  List<dynamic> weekly = ['monday', 'tuesday', 'thursday', 'wednesday', 'friday', 'saturday', 'sunday'];

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
          for(var item in weekly) DailyWeatherCard()
        ],
      ),
    );
  }
}