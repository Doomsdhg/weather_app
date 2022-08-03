import 'package:flutter/material.dart';
import 'package:weather_app/services/api/weather_api.dart';
import 'package:weather_app/components/current_weather_block.dart';
import 'package:weather_app/components/forecast_block.dart';

class CityScreen extends StatefulWidget {
  late String cityName;

  CityScreen({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _cityScreenState(cityName: cityName);
}

class _cityScreenState extends State {
  late String cityName;

  late String locationName;

  late Future<String> locationNameFuture;

  _cityScreenState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  void initState() {
    this.locationNameFuture = _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locationNameFuture,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(locationName),
              ),
              body: Container(
                  margin: EdgeInsets.all(20),
                  constraints: BoxConstraints(minHeight: _getScreenHeight()),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: ColoredBox(
                        color: Colors.grey.shade200,
                        child: Container(
                          child: Column(
                            children: [
                              CurrentWeatherBlock(cityName: cityName),
                              ForecastBlock(
                                cityName: cityName,
                              )
                            ],
                          ),
                        )),
                  )),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<String> _getLocation() async {
    dynamic locationObject = await WeatherApi().getLocation(cityName);
    String location = '${locationObject['name']}, ${locationObject['country']}';
    setState(() {
      locationName = location;
    });
    return location;
  }

  double _getScreenHeight() {
    return MediaQuery.of(context).size.height - 120;
  }
}
