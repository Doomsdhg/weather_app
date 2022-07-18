import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';

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
        onPressed: () => {},
        tooltip: 'Add city',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<String> _getCitiesList(){
    return ['Amsterdam', 'Batumi', 'Copengahen'];
  }
}