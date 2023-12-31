// database/database_helper.dart
import 'package:artventure/database/artventure_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "artventure.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    // ignore: unused_local_variable
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return _database!;
  }

  Future<void> create(Database database, int version) async =>
      await ArtventureDB().createTables(database);
}


// path (await getDatabasesPath())