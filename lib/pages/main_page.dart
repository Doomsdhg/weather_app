import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';
import 'package:weather_app/components/city_management_dialog.dart';

class MainPage extends StatefulWidget {

  @override
  createState() => _mainPageState();
}

class _mainPageState extends State {

  List<String> citiesList = ['Amsterdam', 'Batumi', 'Copengahen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather app'),
      ),
      body: Column(
        children: [
          for(var item in citiesList) CityCard(item, '+25')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CityManagementDialog().build(context)
            .then((value){
              setState(() {
                citiesList.add(value);
              });
            }),
        tooltip: 'Add city',
        child: const Icon(Icons.add),
      ),
    );
  }
}