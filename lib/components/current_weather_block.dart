import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';

class CurrentWeatherBlock extends StatefulWidget {
  late String cityName;

  CurrentWeatherBlock({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  createState() => _currentWeatherBlockState(cityName: cityName);
}

class _currentWeatherBlockState extends State {
  late String cityName;

  late dynamic weather;

  late Future<dynamic> weatherFuture;

  _currentWeatherBlockState({required String cityName}) {
    this.cityName = cityName;
  }

  @override
  void initState() {
    this.weatherFuture = _getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: weatherFuture,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: 170,
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(children: [
                                Container(
                                  child: Text(
                                    'Right now',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                    child: Text(
                                  '${weather['temp_c']}°C',
                                  style: TextStyle(fontSize: 35),
                                )),
                              ]),
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Column(
                                  children: [
                                    Text(
                                      weather['condition']['text'].toString(),
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Image.network(
                                      'https:${_getImageUrl()}',
                                      width: 60,
                                      height: 60,
                                    )
                                  ],
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        )
                      ],
                    ),
                  )),
            );
          else
            return CircularProgressIndicator();
        });
  }

  String _getImageUrl(){
    return weather['condition']['icon'].toString();
  }

  _getCurrentWeather() async {
    dynamic response = await WeatherApi().getCurrentWeather(cityName);
    setState(() {
      weather = response;
    });
    return response;
  }
}
