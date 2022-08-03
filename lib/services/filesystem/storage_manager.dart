import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageManager {

  Future<String> get databasePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get database async {
    final path = await databasePath;
    return File('${path}/db.json');
  }

  Future<String> readDatabase() async {
    try {
      final dbFile = await database;
      String data = await dbFile.readAsString();
      return data;
    } catch(e) {
      return '';
    }
  }

  Future<List<String>> getCitiesList() async {
    var db = await readDatabase();
    if (db == '') {
      return [];
    } else {
      final decodedData = await jsonDecode(db);
      var citiesList = decodedData['citiesList'];
      citiesList = citiesList.cast<String>();
      return filterDuplicates(citiesList: citiesList);
    }
  }

  Future<File> addCityToList(String city) async {
    final db = await database;
    var data = await getCitiesList();
    data.add(city);
    final content = jsonEncode(Database(citiesList: data));
    return db.writeAsString(content);
  }

  Future<File> deleteCity({required String cityName}) async {
    final db = await database;
    List<String> citiesList = await getCitiesList();
    citiesList = deleteCityFromList(citiesList: citiesList, cityToDelete: cityName);
    final content = jsonEncode(Database(citiesList: citiesList));
    return db.writeAsString(content);
  }

  List<String> deleteCityFromList({required String cityToDelete, required List<String> citiesList}){
    return citiesList = citiesList.where((city){
      return city != cityToDelete;
    }).toList();
  }

  List<String> filterDuplicates({required List<String> citiesList}){
    return citiesList.toSet().toList();
  }
}

class Database {
  late List<String> citiesList;

  Database({required List<String> citiesList}){
    this.citiesList = citiesList;
  }

  Database.fromJson(Map<String, dynamic> json)
      : citiesList = json['citiesList']!;

  Map<String, dynamic> toJson() {
    return {
      'citiesList': citiesList
    };
  }
}