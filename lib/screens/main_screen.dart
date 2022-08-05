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

  var now = new DateTime.now();

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
              body: ListView.builder(
                  itemCount: citiesList.length,
                  itemBuilder: (context, index) => CityCard(
                      name: citiesList[index],
                      index: index,
                      dismissableKey: '${citiesList[index]}${now.millisecondsSinceEpoch}',
                      dismissCallback: _deleteCity
                  )
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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  Future<List<String>> _getCitiesList() async {
    final List<String> dbCities = await StorageManager().getCitiesList();
    setState(() {
      this.citiesList = dbCities;
    });
    return dbCities;
  }

  Future<void> _deleteCity(String cityName, int index) async {
    await StorageManager().deleteCity(cityName: cityName);
    setState(() {
      citiesList.removeAt(index);
    });
  }
}
