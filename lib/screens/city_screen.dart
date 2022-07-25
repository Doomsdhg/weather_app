import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {

  late String name;

  CityScreen({required String name}){
    this.name = name;
  }

  @override
  createState() => _cityScreenState(name: name);
}

class _cityScreenState extends State {

  late String name;

  _cityScreenState({required String name}){
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City info'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Title(
                color: Colors.black,
                child: Center(
                  child: Text(
                    '$name',
                    style: TextStyle(
                        fontSize: 30
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}