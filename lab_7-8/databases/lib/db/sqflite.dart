import 'dart:async';
import 'dart:io';

import 'package:databases/db/data.dart';
import 'package:databases/model/vacancy.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider implements SimpleDataSource {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "vacancy.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE vacancy ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "salary FLOAT"
              ")");
        });
  }

  newVacancy(Vacancy newVacancy) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM vacancy");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into vacancy (id,name,salary)"
            " VALUES (?,?,?)",
        [id, newVacancy.name, newVacancy.salary]);
    return raw;
  }
  
  updateVacancy(Vacancy newVacancy) async {
    final db = await database;
    var res = await db.update("vacancy", newVacancy.toMap(),
        where: "id = ?", whereArgs: [newVacancy.id]);
    return res;
  }

  getVacancy(int id) async {
    final db = await database;
    var res = await db.query("vacancy", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Vacancy.fromMap(res.first) : null;
  }
  

  Future<List<Vacancy>> getAllVacancies() async {
    final db = await database;
    var res = await db.query("vacancy");
    List<Vacancy> list =
    res.isNotEmpty ? res.map((c) => Vacancy.fromMap(c)).toList() : [];
    return list;
  }

  deleteVacancy(int id) async {
    final db = await database;
    return db.delete("vacancy", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from vacancy");
  }
}