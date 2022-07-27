import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class DetailedCurrentWeather extends StatefulWidget {

  late String cityName;

  DetailedCurrentWeather({required String cityName}){
    this.cityName = cityName;
  }

  @override
  createState() => _detailedCurrentWeatherState(cityName: cityName);
}

class _detailedCurrentWeatherState extends State {

  DetailedWeather? detailedWeatherObject;

  late String cityName;

  _detailedCurrentWeatherState({required String cityName}){
    this.cityName = cityName;
  }

  @override
  Widget build(BuildContext context){
    if (detailedWeatherObject == null)
      buildDetailedWeatherObject();
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('condition',
              style: TextStyle(
                fontSize: 18
              ),),
              Text(detailedWeatherObject!.condition,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('wind speed',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.windSpeed,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('wind direction',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.windDirection,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('humidity',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.humidity,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('visibility',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.visibility,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('gust',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.gust,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ultraviolet index',
                  style: TextStyle(
                      fontSize: 18
                  )),
              Text(detailedWeatherObject!.ultravioletIndex,
                  style: TextStyle(
                      fontSize: 18
                  )),
            ],
          )
        ],
      ),
    );
  }

  void buildDetailedWeatherObject() async {
    dynamic currentWeatherResponse = await WeatherApi().getCurrentWeather(cityName);
    setState((){
      detailedWeatherObject = DetailedWeather(currentWeatherResponse);
    });
  }
}

class DetailedWeather {
  String condition = '';
  String windSpeed = '';
  String windDirection = '';
  String humidity = '';
  String visibility = '';
  String gust = '';
  String ultravioletIndex = '';

  DetailedWeather(dynamic currentWeatherResponse){
    condition = currentWeatherResponse['condition']['text'].toString();
    windSpeed = currentWeatherResponse['wind_kph'].toString();
    windDirection = currentWeatherResponse['wind_dir'].toString();
    humidity = currentWeatherResponse['humidity'].toString();
    visibility = currentWeatherResponse['visibility'].toString();
    gust = currentWeatherResponse['gust_kph'].toString();
    ultravioletIndex = currentWeatherResponse['uv'].toString();
  }
}