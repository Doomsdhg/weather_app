import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';
import 'package:weather_app/components/city_management_dialog.dart';
import 'package:weather_app/components/info_dialog.dart';
import 'package:weather_app/services/filesystem/storage_manager.dart';

class MainScreen extends StatefulWidget {
  @override
  createState() => _mainScreenState();
}

class _mainScreenState extends State {
  late List<String> citiesList;

  late Future<List<String>> _citiesListFuture;

  @override
  void initState() {
    this._citiesListFuture = _getCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _citiesListFuture,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Weather'),
                  IconButton(
                      onPressed: () => InfoDialog().build(context),
                      icon: Icon(Icons.info))
                ],
              )),
              body: Column(
                children: [for (var item in citiesList) CityCard(name: item, refreshCallback: _getCitiesList)],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    CityManagementDialog().build(context).then((value) async {
                      await StorageManager().addCityToList(value);
                      await _getCitiesList();
                    }),
                tooltip: 'Add city',
                child: const Icon(Icons.add),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<String>> _getCitiesList() async {
    final List<String> dbCities = await StorageManager().getCitiesList();
    setState(() {
      this.citiesList = dbCities;
    });
    return dbCities;
  }
}
