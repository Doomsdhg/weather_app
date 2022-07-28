import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class ForecastBlock extends StatefulWidget {
  late String cityName;

  ForecastBlock({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _forecastBlockState(cityName: cityName);
}

class _forecastBlockState extends State {
  bool todayPressed = true;
  bool twoDaysPressed = false;
  bool threeDaysPressed = false;

  late String cityName;

  late List<dynamic> forecast;

  late Future<List<dynamic>> forecastFuture;

  _forecastBlockState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  void initState() {
    this.forecastFuture = _getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: forecastFuture,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: _getButtonColor(todayPressed)),
                            onPressed: () {
                              setState(() {
                                todayPressed = true;
                                twoDaysPressed = false;
                                threeDaysPressed = false;
                              });
                              _getForecast();
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    _getButtonColor(twoDaysPressed)),
                            onPressed: () {
                              setState(() {
                                todayPressed = false;
                                twoDaysPressed = true;
                                threeDaysPressed = false;
                              });
                              _getForecast();
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  '+1',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    _getButtonColor(threeDaysPressed)),
                            onPressed: () {
                              setState(() {
                                todayPressed = false;
                                twoDaysPressed = false;
                                threeDaysPressed = true;
                              });
                              _getForecast();
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  '+2',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Table(
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade400))),
                              children: [
                                Center(
                                  child: Text(
                                    'Time',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Center(
                                    child: Text('Weather',
                                        style: TextStyle(fontSize: 20))),
                                Center(
                                    child: Text('Temperature',
                                        style: TextStyle(fontSize: 20))),
                              ]),
                          for (var item in forecast) _buildRow(item)
                        ],
                      ),
                    )
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  TableRow _buildRow(dynamic forecastObject) => TableRow(children: [
        Center(
            child: Text(
          '${forecastObject['time']}',
          style: TextStyle(fontSize: 18),
        )),
        Center(
            child: Image.asset(
          'images/sunny_rainy.png',
          height: 25,
          width: 25,
        )),
        Center(
            child: Text(
          '${forecastObject['temp_c']}°C',
          style: TextStyle(fontSize: 18),
        )),
      ]);

  MaterialStateProperty<Color> _getButtonColor(bool isPressed) {
    final buttonColor = isPressed ? Colors.blue : Colors.grey.shade200;
    return MaterialStateProperty.all<Color>(buttonColor);
  }

  Future<List<dynamic>> _getForecast() async {
    var response = await WeatherApi()
        .getForecast(city: cityName, days: _getForecastDuration());
    List<dynamic> hourlyForecast = _filterLastedHours(response);
    setState(() {
      forecast = hourlyForecast;
    });
    return hourlyForecast;
  }

  List<dynamic> _filterLastedHours(dynamic response) {
    final localCurrentTime = DateTime.parse(response['location']['localtime']);
    List<dynamic> dailyForecast = response['forecast']['forecastday'];
    List<dynamic> hourlyForecast = [];
    dailyForecast.map((day) {
      List<dynamic> dayHourlyForecast = day['hour'];
      dayHourlyForecast.forEach((hour) {
        hourlyForecast.add(hour);
      });
    }).toList();
    final filteredHourlyForecast = hourlyForecast.where((forecastObject) {
      final forecastTime = DateTime.parse(forecastObject['time']);
      return forecastTime.compareTo(localCurrentTime) > 0;
    }).toList();
    return filteredHourlyForecast;
  }

  String _getForecastDuration() {
    if (todayPressed)
      return '1';
    else if (twoDaysPressed)
      return '2';
    else
      return '3';
  }
}
