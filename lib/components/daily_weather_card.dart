import 'package:flutter/material.dart';

class DailyWeatherCard extends StatefulWidget {
  @override
  createState() => _dailyWeatherCard();
}

class _dailyWeatherCard extends State {

  @override
  Widget build(BuildContext context){
    return Container(
        height: 30,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monday'),
              Image.asset('images/sunny_rainy.png'),
              Text('25°C'),
              Text('17°C')
            ],
          ),
        )
    );
  }
}