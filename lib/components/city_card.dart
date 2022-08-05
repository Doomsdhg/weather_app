import 'package:flutter/material.dart';
import 'package:weather_app/services/api/weather_api.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/filesystem/storage_manager.dart';

class CityCard extends StatefulWidget {

  late String name;

  late int index;

  CityCard({required String name, required int index}){
    this.name = name;
    this.index = index;
  }

  @override
  _CityCardState createState() => _CityCardState(cityName: name, index: index);
}

class _CityCardState extends State {

  late String cityName;

  late String temperature;

  late Future<double> temperatureFuture;

  late int index;

  double cardHeight = 100;

  _CityCardState({required String cityName, required int index}){
    this.cityName = cityName;
    this.index = index;
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
            return _showDialog().then((value) async {
              if (value == true) {
                await StorageManager().deleteCity(cityName: cityName);
                _hideCard();
              }
            });
          },
          child: Container(
            height: cardHeight,
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
        return CircularProgressIndicator();
      }
    });
  }

  _showDialog(){
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm city deletion'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  _hideCard(){
    setState(() {
      cardHeight = 0;
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
