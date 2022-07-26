import 'package:flutter/material.dart';

class HourlyWeatherCard extends StatefulWidget {
  @override
  createState() => _hourlyWeatherCardState();
}

class _hourlyWeatherCardState extends State {

  @override
  Widget build(BuildContext context){
    return Container(
      height: 30,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('09:00'),
            Image.asset('images/sunny_rainy.png'),
            Text('25°C')
          ],
        ),
      )
    );
  }
}