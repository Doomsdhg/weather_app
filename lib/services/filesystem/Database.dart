import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:weather_app/constants/constants.dart';

class Database {
  Future<String> get databasePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> fetch() async {
    final path = await databasePath;
    return File('${path}${DatabaseAccessors.DB_FILENAME}');
  }
}
