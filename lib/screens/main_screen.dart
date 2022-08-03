import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';
import 'package:weather_app/components/city_management_dialog.dart';
import 'package:weather_app/components/info_dialog.dart';

class MainScreen extends StatefulWidget {
  @override
  createState() => _mainScreenState();
}

class _mainScreenState extends State {
  List<String> citiesList = ['Amsterdam', 'Batumi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Weather'),
          IconButton(
              onPressed: () => InfoDialog().build(context),
              icon: Icon(Icons.info)
          )
        ],
      )),
      body: Column(
        children: [for (var item in citiesList) CityCard(name: item)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CityManagementDialog().build(context).then((value) {
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
