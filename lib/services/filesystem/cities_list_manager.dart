import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/filesystem/storage_manager.dart';

class CitiesListManager {
  Future<List<String>> getCitiesList() async {
    final List<dynamic>? citiesList = await StorageManager()
        .getEntity(entityName: DatabaseAccessors.CITIES_LIST);
    if (citiesList == null) {
      return [];
    }
    return filterCityDuplicates(citiesList: citiesList.cast<String>());
  }

  Future<void> addCityToList(String city) async {
    List<String> citiesList = await getCitiesList();
    citiesList.add(city);
    await StorageManager().writeToEntity(
        entityName: DatabaseAccessors.CITIES_LIST,
        encodedData: getEncodedList(citiesList)
    );
  }

  Future<void> deleteCity({required String cityName}) async {
    List<String> citiesList = await getCitiesList();
    citiesList = deleteCityFromList(
        citiesList: citiesList,
        cityToDelete: cityName
    );
    await StorageManager().writeToEntity(
        entityName: DatabaseAccessors.CITIES_LIST,
        encodedData: getEncodedList(citiesList)
    );
  }

  List<String> deleteCityFromList({
    required String cityToDelete,
    required List<String> citiesList
  }) {
    return citiesList.where((city) {
      return city != cityToDelete;
    }).toList();
  }

  List<String> filterCityDuplicates({required List<String> citiesList}) {
    return citiesList.toSet().toList();
  }

  dynamic getEncodedList(List<String> citiesList){
    return jsonEncode(_database(citiesList: citiesList));
  }
}

class _database {
  late List<String> citiesList;

  _database({required List<String> citiesList}) {
    this.citiesList = citiesList;
  }

  _database.fromJson(Map<String, dynamic> json)
      : citiesList = json[DatabaseAccessors.CITIES_LIST]!;

  Map<String, dynamic> toJson() {
    return {DatabaseAccessors.CITIES_LIST: citiesList};
  }
}