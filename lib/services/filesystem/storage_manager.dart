import 'dart:convert';
import 'dart:io';
import 'package:weather_app/services/filesystem/Database.dart';

class StorageManager {

  Future<bool> get dbExists async{
    final File dbFile = await Database().fetch();
    return dbFile.exists();
  }

  Future<dynamic> readDatabase() async {
    final dbFile = await Database().fetch();
    String data = await dbFile.readAsString();
    return jsonDecode(data);
  }

  Future<dynamic> getEntity<T>({required String entityName}) async {
    if (await dbExists) {
      var db = await readDatabase();
      print(db);
      return db[entityName];
    } else {
      return null;
    }
  }

  Future<File> writeToEntity({
    required String entityName,
    required dynamic encodedData
  }) async {
    File db = await Database().fetch();
    if (await dbExists){
      dynamic dbData = await readDatabase();
      dynamic data = jsonDecode(encodedData);
      dbData[entityName] = data[entityName];
      final content = jsonEncode(dbData);
      return await db.writeAsString(content);
    } else {
      return await db.writeAsString(jsonEncode(encodedData));
    }
  }
}
