import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';
import 'package:weather_app/components/city_adding_dialog.dart';

class MainPage extends StatelessWidget {

  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          for(var item in _getCitiesList()) CityCard(item, '+25')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CityAddingDialog().build(context),
        tooltip: 'Add city',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<String> _getCitiesList(){
    return ['Amsterdam', 'Batumi', 'Copengahen'];
  }
}