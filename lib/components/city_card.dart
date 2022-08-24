import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/api/weather_api.dart';

class CityCard extends StatelessWidget {

  late City cityData;

  CityCard(this.cityData);

  Widget build(BuildContext context){
    return FutureBuilder(
        future: cityData.getCurrentTemperature(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
      if (cityData.temperature != null) {
        return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return CityScreen(cityName: cityData.name);
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
                                '${cityData.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontConstants.MIDDLE_SIZE
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${cityData.temperature}${TemperatureConstants.CELCIUS}',
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
}

class City {
   late String name;
   double? temperature;

   City({required String name}){
    this.name = name;
   }

   Future<double> getCurrentTemperature() async {
     double currentTemperature = await WeatherApi().getCurrentTemperature(name);
     temperature = currentTemperature;
     return currentTemperature;
   }
}