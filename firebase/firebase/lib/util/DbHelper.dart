import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/vacancy.dart';

class DbHelper {
  static Future<Database> database;

  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'cloth_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cloth(id INTEGER PRIMARY KEY, color TEXT, material TEXT, pocketNumber INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertCloth(Vacancy vacancy) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'vacancy',
      vacancy.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Vacancy>> getCloth() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('vacancy');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Vacancy(
        id: maps[i]['id'],
        name: maps[i]['color'],
        salary: maps[i]['vacancy'],
      );
    });
  }

  static Future<void> updateCloth(Vacancy cloth) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'cloth',
      cloth.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [cloth.id],
    );
  }

  static Future<void> deleteCloth(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'cloth',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}