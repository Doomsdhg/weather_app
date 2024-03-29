import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/services/api/weather_api.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/api/weather_api.dart';

class ForecastBlock extends StatefulWidget {
  late String cityName;

  ForecastBlock({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _forecastBlockState(cityName: cityName);
}

class _forecastBlockState extends State {

  ButtonsState buttonsState = ButtonsState();

  late String cityName;

  late List<dynamic> forecast;

  late Future<List<dynamic>> forecastFuture;

  late String forecastDate;

  late dynamic savedData;

  bool displaySpinner = true;

  _forecastBlockState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  void initState() {
    buttonsState.initState();
    this.forecastFuture = _getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        backgroundColor: _getButtonColor(buttonsState.today)),
                    onPressed: () {
                      buttonsState.refreshState();
                      buttonsState.today = true;
                      setState(() {
                        displaySpinner = true;
                      });
                      forecastFuture = _getForecast();
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Today',
                          style: TextStyle(
                              color: Colors.black, fontSize: FontConstants.MIDDLE_SIZE),
                        )),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            _getButtonColor(buttonsState.tomorrow)),
                    onPressed: () {
                      buttonsState.refreshState();
                      buttonsState.tomorrow = true;
                      setState(() {
                        displaySpinner = true;
                      });
                      forecastFuture = _getForecast();
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '+1',
                          style: TextStyle(
                              color: Colors.black, fontSize: FontConstants.MIDDLE_SIZE),
                        )),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            _getButtonColor(buttonsState.dayAfterTomorrow)),
                    onPressed: () {
                      buttonsState.refreshState();
                      buttonsState.dayAfterTomorrow = true;
                      setState(() {
                        displaySpinner = true;
                      });
                      forecastFuture = _getForecast();
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '+2',
                          style: TextStyle(
                              color: Colors.black, fontSize: FontConstants.MIDDLE_SIZE),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 5),
                      ),
                    ]
              ),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 3, color: Colors.grey.shade300),
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: FutureBuilder<List<dynamic>>(
                          future: forecastFuture,
                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (!displaySpinner) {
                              return Text(
                                forecastDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: FontConstants.LARGE_SIZE
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        ),
                      ),
                    ),
                  Container(
                    height: 330,
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: FutureBuilder<List<dynamic>>(
                        future: forecastFuture,
                        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (!displaySpinner) {
                            return Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                for (var item in forecast) _buildRow(item)
                              ],
                            );
                          } else {
                            return Container(
                              height: 150,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()
                            );
                          }
                        }
                      ),
                    )
                  ),
                ],
              )    
            ),
          ),
        ],
      )
    );
  }

  TableRow _buildRow(dynamic forecastObject) => TableRow(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            _transformTime(forecastObject[DateTimeAccessors.TIME]),
            style: TextStyle(fontSize: FontConstants.SMALL_SIZE),
          ),
        ),
        Row(
          children: [
            Image.network(
              _getImageUrl(forecastObject),
              width: 30,
              height: 30,
            ),
            Text(
              '${forecastObject[WeatherAccessors.CELCIUS_TEMPERATURE]}${TemperatureConstants.CELCIUS}',
              style: TextStyle(fontSize: FontConstants.SMALL_SIZE),
            )
          ],
        )
      ]);

  String _getImageUrl(dynamic forecastObject){
    return '${UrlConstants.HTTPS_PROTOCOL}${forecastObject[ConditionAccessors.CONDITION][ConditionAccessors.ICON]}';
  }

  String _setForecastDate(List<dynamic> hourlyForecast){
    return hourlyForecast[0][DateTimeAccessors.TIME].toString().substring(0, 10);
  }

  String _transformTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String output = '${dateTime.hour}${TimeConstants.EXACTLY_HOUR}';
    return output;
  }

  MaterialStateProperty<Color> _getButtonColor(bool isPressed) {
    final buttonColor = isPressed ? Colors.blue : Colors.grey.shade200;
    return MaterialStateProperty.all<Color>(buttonColor);
  }

  Future<List<dynamic>> _getForecast() async {
    var response = await WeatherApi().getForecast(city: cityName, days: _getForecastLength());
    List<dynamic> hourlyForecast = _filterPassedHours(response);
    setState(() {
      displaySpinner = false;
      forecast = hourlyForecast;
      forecastDate = _setForecastDate(hourlyForecast);
      savedData = hourlyForecast;
    });
    return hourlyForecast;
  }

  List<dynamic> _filterPassedHours(dynamic response) {
    final DateTime localCurrentTime = _correctTimeFormat(response);
    List<dynamic> dailyForecast = response[WeatherAccessors.FORECAST][WeatherAccessors.FORECAST_DAY];
    List<dynamic> hourlyForecast = dailyForecast.last[ForecastAccessors.HOUR];
    final filteredHourlyForecast = hourlyForecast.where((forecastObject) {
      final forecastTime = DateTime.parse(forecastObject[DateTimeAccessors.TIME]);
      return forecastTime.compareTo(localCurrentTime) > 0;
    }).toList();
    return filteredHourlyForecast;
  }

  DateTime _correctTimeFormat(dynamic response){
    String dateTime = response[LocationAcessors.LOCATION][LocationAcessors.LOCAL_TIME].toString();
    String time = dateTime.substring(dateTime.indexOf(" ") + 1);
    if (time.length == 4) {
      dateTime = dateTime.replaceFirst(time, "0$time");
    }
    return DateTime.parse(dateTime);
  }

  String _getForecastLength() {
    if (buttonsState.today)
      return ForecastLengthConstants.ONE_DAY;
    else if (buttonsState.tomorrow)
      return ForecastLengthConstants.TWO_DAYS;
    else
      return ForecastLengthConstants.THREE_DAYS;
  }
}

class ButtonsState {
  bool today = false;
  bool tomorrow = false;
  bool dayAfterTomorrow = false;

  initState(){
    today = true;
  }

  refreshState(){
    today = false;
    tomorrow = false;
    dayAfterTomorrow = false;
  }
}