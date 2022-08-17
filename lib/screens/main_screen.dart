import 'package:flutter/material.dart';
import 'package:weather_app/components/city_card.dart';
import 'package:weather_app/components/city_management_dialog.dart';
import 'package:weather_app/components/info_dialog.dart';
import 'package:weather_app/services/filesystem/cities_list_manager.dart';
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
              body: FutureBuilder(
                future: _citiesListFuture,
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: citiesList.length,
                      itemBuilder: (context, index) => Dismissible(
                          key: UniqueKey(),
                          onDismissed: (dismissDirection) async {
                            await _deleteCity(index);
                          },
                          confirmDismiss: (dismissDirection) => _showConfirmDeletionDialog(context),
                          child: CityCard(
                              name: citiesList[index]
                          )
                      )
                  );
                  } else {
                   return CircularProgressIndicator();
                  }
                }
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    CityManagementDialog().build(context).then((value) async {
                      await CitiesListManager().addCityToList(value);
                      await _getCitiesList();
                    }),
                tooltip: 'Add city',
                child: const Icon(Icons.add),
              ),
            );
  }

  _showConfirmDeletionDialog(BuildContext dismissableContext){
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
    ).then((value) {
      return value;
    });
  }

  Future<List<String>> _getCitiesList() async {
    final List<String> dbCities = await CitiesListManager().getCitiesList();
    setState(() {
      this.citiesList = dbCities;
    });
    return dbCities;
  }

  Future<void> _deleteCity(int index) async {
    await CitiesListManager().deleteCity(cityName: citiesList[index]);
    setState(() {
      citiesList.removeAt(index);
    });
  }
}
