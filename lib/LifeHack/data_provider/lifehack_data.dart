import 'dart:io';
import 'package:flutter_app/LifeHack/model/lifehack.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final _databaseName = 'LifeHackDatabase.db';
  static final _databaseVersion = 1;

  static final _lifeHackTable = "LifeHacks";

  static final _columnId = "id";
  static final _columnCategory = 'category';
  static final _columnTip = 'tip';
  static final _columnIsFaved = 'isFaved';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    // var dbPath = await getDatabasesPath();
    String path = join(directory.path, _databaseName);
    // await deleteDatabase(path);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $_lifeHackTable (
            $_columnId INTEGER PRIMARY KEY,
            $_columnCategory TEXT NOT NULL,
            $_columnTip Text NOT NULL,
            $_columnIsFaved INTEGER NOT NULL
          )
          ''');
    });
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertHack(LifeHack lifeHack) async {
    Database db = await instance.database;
    var value = await db.insert(_lifeHackTable, lifeHack.toMap());
    return value;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<LifeHack>> queryAllHacks() async {
    Database db = await instance.database;
    final response = await db.query(_lifeHackTable);
    return response.map((lifehack) => LifeHack.fromJson(lifehack)).toList();
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $_lifeHackTable'));
  }

  // return the number of lifehacks in each category
  Future<int> qeryRowCategory(String category) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $_lifeHackTable WHERE $_columnCategory = $category'));
  }

  // fetch lifehack by id
  Future<LifeHack> queryHackById(int id) async {
    Database db = await instance.database;
    final response =
        await db.query(_lifeHackTable, where: 'id=?', whereArgs: [id]);
    return response.isEmpty ? LifeHack.fromJson(response.first) : null;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateHack(LifeHack lifeHack) async {
    Database db = await instance.database;
    int id = lifeHack.id;
    var value = await db.update(_lifeHackTable, lifeHack.toMap(),
        where: '$_columnId = ?', whereArgs: [id]);
    return value;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.

  Future<int> deleteHack(int id) async {
    Database db = await instance.database;
    var value = await db
        .rawDelete('DELETE FROM LifeHacks WHERE id = ?',[id]);
    return value;
  }

  Future<List<String>> getTables() async {
    Database db = await instance.database;
    var tableNames = (await db
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);

    return tableNames;
  }
}
