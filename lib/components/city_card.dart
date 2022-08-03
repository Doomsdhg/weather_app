import 'package:flutter/material.dart';
import 'package:weather_app/services/api/weather_api.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/filesystem/storage_manager.dart';

class CityCard extends StatefulWidget {

  late String name;

  late Function refreshCallback;

  CityCard({required String name, required Function refreshCallback}){
    this.name = name;
    this.refreshCallback = refreshCallback;
  }

  @override
  _CityCardState createState() => _CityCardState(cityName: name, refreshCallback: refreshCallback);
}

class _CityCardState extends State {

  late String cityName;

  late Function refreshCallback;

  late String temperature;

  late Future<double> temperatureFuture;

  _CityCardState({required String cityName, required Function refreshCallback}){
    this.cityName = cityName;
    this.refreshCallback = refreshCallback;
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
          onLongPress: () async {
            await StorageManager().deleteCity(cityName: cityName);
            await refreshCallback();
          },
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
        );
      }
      else {
        return CircularProgressIndicator();
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
