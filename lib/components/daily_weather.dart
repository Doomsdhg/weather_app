import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class DailyWeather extends StatefulWidget {

  late String cityName;

  DailyWeather({required String cityName}){
    this.cityName = cityName;
  }

  @override
  createState() => _dailyWeatherState(cityName: cityName);
}

class _dailyWeatherState extends State {

  late String cityName;

  String dropdownValue = '7';

  _dailyWeatherState({required String cityName}){
    this.cityName = cityName;
  }

  List<dynamic> daily = [];

  @override
  Widget build(BuildContext context) {
    if (daily.length == 0)
      getForecast();
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Table(
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
                      Center(child: Text('Highest',
                          style: TextStyle(
                              fontSize: 20
                          ))),
                      Center(child: Text('Lowest',
                          style: TextStyle(
                              fontSize: 20
                          )))
                    ]),
                for (var item in daily) buildRow(item)
              ],
            )
          ],
        ));
  }

  TableRow buildRow(dynamic cell) => TableRow(children: [
        Center(child: Text(cell['date'].toString())),
        Center(
            child: Image.asset(
          'images/sunny_rainy.png',
          height: 25,
          width: 25,
        )),
        Center(child: Text(cell['day']['maxtemp_c'].toString())),
        Center(child: Text(cell['day']['mintemp_c'].toString()))
      ]);

  void getForecast() async {
    print(dropdownValue);
    List<dynamic> forecast = await WeatherApi().getForecast(city: cityName, days: dropdownValue);
    // print(forecast);
    setState(() {
      daily = forecast;
    });
    print(daily);
  }
}
