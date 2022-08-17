import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/api/weather_api.dart';


class CityCard extends StatefulWidget {

  late String name;

  CityCard({required String name}){
    this.name = name;
  }

  @override
  _CityCardState createState() => _CityCardState(
      cityName: name
  );
}

class _CityCardState extends State {

  late String cityName;

  late String temperature;

  late Future<double> temperatureFuture;

  _CityCardState({required String cityName}){
    this.cityName = cityName;
  }

  @override
  void initState() {
    this.temperatureFuture = _getCurrentTemperature();
    super.initState();
  }

  Widget build(BuildContext context){
    return FutureBuilder(
        future: temperatureFuture,
        builder: (context, AsyncSnapshot<dynamic> snapshot){
      if (snapshot.hasData) {
        return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return CityScreen(cityName: cityName);
                      })
                  );
                },
                child: Container(
                  child: Card(
                      child: Container(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$cityName',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontConstants.MIDDLE_SIZE
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${temperature}${TemperatureConstants.CELCIUS}',
                                  style: TextStyle(
                                      fontSize: FontConstants.LARGE_SIZE
                                  ),
                                )
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        padding: EdgeInsets.all(20),
                      )
                  ),
                )
            );
      }
      else {
        return Card(
          child: Container(
            height: 80,
            child: Align(
            alignment: Alignment.topLeft,
            child: CircularProgressIndicator(),
            ),
          )
        );
      }
    });
  }

  Future<double> _getCurrentTemperature() async {
    final double currentTemperature = await WeatherApi().getCurrentTemperature(cityName);
    setState((){
      temperature = currentTemperature.toString();
    });
    return currentTemperature;
  }
}
