import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../models/models.dart';

class DB {
  Database? db;

  Future openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    db = await openDatabase(
      join(await getDatabasesPath(), 'cat_database.db'),
      onCreate: (Database db, version) {
        return db.execute(
          'CREATE TABLE cats(id TEXT PRIMARY KEY, url TEXT, isFav BIT)',
        );
      },
      version: 1,
    );
    print('DB opened');
  }
  // Future openDB() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final Future<Database> database = openDatabase(
  //     join(await getDatabasesPath(), 'cat_database.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         'CREATE TABLE cats(id TEXT PRIMARY KEY, url TEXT, isFav BIT)',
  //       );
  //     },
  //     version: 1,
  //   );
  //   return database;
  // }

  // Function that inserts cats into the database
  Future<void> insertCatToDb(Cat cat) async {
    // final db = await openDB();

    // Insert the Cat into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same cat is inserted twice.
    //
    // In this case, replace any previous data.

    try {
      await db!.insert(
        'cats',
        cat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
      // throw e;
    }

    // await db.close();
  }

  // A method that retrieves all the cats from the cats table.
  Future<List<Cat>> getCatsFromDb() async {
    // Get a reference to the database.
    // final db = await openDB();

    // Query the table for all the cats.
    try {
      final List<Map<String, dynamic>> maps = await db!.query('cats');

      // Convert the List<Map<String, dynamic> into a List<Cat>.
      final List<Cat> catsList = List.generate(maps.length, (i) {
        return Cat(
          id: maps[i]['id'],
          url: maps[i]['url'],
          isFav: (maps[i]['isFav'] == 1) ? true : false,
        );
      });

      // await db.close();
      // print('FROM DATABASE: $catsList');         //Print Cats
      return catsList;
    } catch (e) {
      print(e);
      return [];
      // throw e;
    }
  }

  void close() async {
    db!.close();
  }
}
