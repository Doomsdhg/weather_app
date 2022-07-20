import 'package:flutter/material.dart';

class CityCard extends StatefulWidget {

  late String name;
  late String temperature;

  CityCard(String name, String temperature){
    this.name = name;
    this.temperature = temperature;
  }

  @override
  _CityCardState createState() => _CityCardState(this.name, this.temperature);
}

class _CityCardState extends State {

  String? name;
  String? temperature;

  _CityCardState(String? name, String? temperature){
    this.name = name;
    this.temperature = temperature;
  }

  Widget build(BuildContext context) {
    print(context);
    return Card(
      child: Container(
        child: Row(
          children: [
            Text(
                '$name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
            ),
            Container(
              child: Text(
                  '$temperature',
                  style: TextStyle(
                    fontSize: 30
                ),
              ),
              margin: EdgeInsets.only(left: 20),
            )
          ],
        ),
        padding: EdgeInsets.all(20),
      )
    );
  }
}
