import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/constants/constants.dart';

class StorageManager {
  Future<String> get databasePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get database async {
    final path = await databasePath;
    return File('${path}${DatabaseAccessors.DB_FILENAME}');
  }

  Future<String> readDatabase() async {
    final dbFile = await database;
    String data = await dbFile.readAsString();
    return data;
  }

  Future<List<String>> getCitiesList() async {
    final File dbFile = await database;
    if (await dbFile.exists()) {
      var db = await readDatabase();
      final decodedData = await jsonDecode(db);
      var citiesList = decodedData[DatabaseAccessors.CITIES_LIST];
      citiesList = citiesList.cast<String>();
      return filterDuplicates(citiesList: citiesList);
    } else {
      return [];
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
    citiesList = deleteCityFromList(
        citiesList: citiesList,
        cityToDelete: cityName
    );
    final content = jsonEncode(Database(citiesList: citiesList));
    return db.writeAsString(content);
  }

  List<String> deleteCityFromList({
    required String cityToDelete,
    required List<String> citiesList
  }) {
    return citiesList.where((city) {
      return city != cityToDelete;
    }).toList();
  }

  List<String> filterDuplicates({required List<String> citiesList}) {
    return citiesList.toSet().toList();
  }
}

class Database {
  late List<String> citiesList;

  Database({required List<String> citiesList}) {
    this.citiesList = citiesList;
  }

  Database.fromJson(Map<String, dynamic> json)
      : citiesList = json[DatabaseAccessors.CITIES_LIST]!;

  Map<String, dynamic> toJson() {
    return {DatabaseAccessors.CITIES_LIST: citiesList};
  }
}
