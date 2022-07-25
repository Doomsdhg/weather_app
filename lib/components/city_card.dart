import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/screens/city_screen.dart';

class CityCard extends StatefulWidget {

  late String name;

  CityCard({required String name}){
    this.name = name;
  }

  @override
  _CityCardState createState() => _CityCardState(this.name);
}

class _CityCardState extends State {

  late String name;
  String temperature = '';

  _CityCardState(String name){
    this.name = name;
  }

  Widget build(BuildContext context){
    _setCurrentTemperature();
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return CityScreen(name: name);
          })
        );
      },
      child: Card(
          child: Container(
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$temperature°C',
                      style: TextStyle(
                          fontSize: 30
                      ),
                    )
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            padding: EdgeInsets.all(20),
          )
      ),
    );
  }

  void _setCurrentTemperature() async {
    final int currentTemperature = await WeatherApi().getCurrentWeather(name);
    setState((){
      temperature = currentTemperature.toString();
    });
  }
}
