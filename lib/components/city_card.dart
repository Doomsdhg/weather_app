import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/api/weather_api.dart';


class CityCard extends StatefulWidget {

  late String name;

  late String dismissableKey;

  late int index;

  late Function dismissCallback;

  CityCard({
    required String name,
    required String dismissableKey,
    required Function dismissCallback,
    required int index}){
    this.name = name;
    this.dismissableKey = dismissableKey;
    this.index = index;
    this.dismissCallback = dismissCallback;
  }

  @override
  _CityCardState createState() => _CityCardState(
      cityName: name,
      index: index,
      dismissCallback: dismissCallback,
      dismissableKey: dismissableKey
  );
}

class _CityCardState extends State {

  late String cityName;

  late String temperature;

  late Future<double> temperatureFuture;

  late int index;

  late String dismissableKey;

  late Function dismissCallback;

  _CityCardState({required String cityName, required String dismissableKey, required Function dismissCallback, required int index}){
    this.cityName = cityName;
    this.index = index;
    this.dismissableKey = dismissableKey;
    this.dismissCallback = dismissCallback;
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
        return Dismissible(
            key: ValueKey<String>(dismissableKey),
            onDismissed: (dismissDirection) async {
              await dismissCallback(cityName, index);
            },
            confirmDismiss: (dismissDirection) => _showConfirmationDialog(context),
            child: GestureDetector(
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

  _showConfirmationDialog(BuildContext dismissableContext){
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
    ).then((value) async {
      return value;
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
