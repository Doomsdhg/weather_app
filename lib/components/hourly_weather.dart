import 'package:flutter/material.dart';

class HourlyWeather extends StatefulWidget {
  @override
  createState() => _hourlyWeatherState();
}

class _hourlyWeatherState extends State {
  List<dynamic> hourly = ['09:00', '10:00', '11:00', '09:00', '10:00', '11:00', '09:00', '10:00', '11:00', '09:00', '10:00', '11:00'];

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Table(
        children: [
          TableRow(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade400))
              ),
              children: [
                Center(
                  child: Text('Day',
                    style: TextStyle(
                        fontSize: 20
                    ),),
                ),
                Center(child: Text('Weather',
                    style: TextStyle(
                        fontSize: 20
                    ))),
                Center(child: Text('Temperature',
                    style: TextStyle(
                        fontSize: 20
                    ))),
              ]),
          for (var item in hourly) buildRow(item)
        ],
      ),
    );
  }

  TableRow buildRow(String cell) => TableRow(children: [
    Center(child: Text(cell)),
    Center(
        child: Image.asset(
          'images/sunny_rainy.png',
          height: 25,
          width: 25,
        )),
    Center(child: Text('22°C')),
  ]);
}