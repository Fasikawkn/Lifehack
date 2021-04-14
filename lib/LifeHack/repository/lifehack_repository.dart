import 'package:flutter_app/LifeHack/data_provider/data_provider.dart';
import 'package:flutter_app/LifeHack/model/lifehack.dart';
import 'package:meta/meta.dart';

class LifeHackRepository {
  final DatabaseHelper databaseHelper;

  LifeHackRepository({@required this.databaseHelper})
      : assert(databaseHelper != null);
  // this calls the queryHackById() method of the database;
  Future<LifeHack> getLifeHackById(int id) async {
    return await databaseHelper.queryHackById(id);
  }

  // this calls the queryAllHacks() method of the database
  Future<List<LifeHack>> getAllLifeHacks() async {
    return await databaseHelper.queryAllHacks();
  }

// this calls the insertHack() of the database
  Future<int> addLifeHack(LifeHack lifeHack) async {
    return await databaseHelper.insertHack(lifeHack);
  }

  // this calls the updateHack() of the database
  Future<int> updateLifeHack(LifeHack lifeHack) async {
    return await databaseHelper.updateHack(lifeHack);
  }

  // this calls the deleteHack() of the database
  Future<int> deleteLifeHack(int id) async {
    return await databaseHelper.deleteHack(id);
  }

  // this calls the qeryRowCategory() of the database
  Future<int> getLifeHacksInEachCategory(String category) async {
    return await databaseHelper.qeryRowCategory(category);
  }

  // this calls the queryRowCount(); of the database;
  Future<int> getRowCount() async {
    return await databaseHelper.queryRowCount();
  }
}
