import 'dart:async';

import 'package:legacyweather/data_models/city.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase();

  static const databaseName = 'city_table.db';
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      return await initializeDB();
    } else {
      return _database;
    }
  }

  initializeDB() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (db, version) async {
      return await db
          .execute('CREATE TABLE tablecity(id INTEGER PRIMARY KEY, name TEXT)');
    });
  }

  bool getStatus(int status) {
    return status == 1 ? true : false;
  }

  City returnCity(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      name: map['name'],
    );
  }

  Stream<List<City>> getCityList() async* {
    final Database? db = await (database);
    final List<Map<String, dynamic>> cityList = await db!.query('tablecity');
    yield cityList.map(returnCity).toList();
  }

  Future<void> insertData(City city) async {
    final Database? db = await (database);
    db!.insert('tablecity', city.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> update(City city) async {
    final Database? db = await (database);
    db!.update('tablecity', city.toMap(),
        where: 'id = ?', whereArgs: [city.id]);
  }

  Future<void> delete(City city) async {
    final Database? db = await (database);
    db!.delete('tablecity', where: 'id = ?', whereArgs: [city.id]);
  }
}
