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
  Future<List<Cat>> getCatsFromDb(int page, int limit) async {
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

      final int pagination = page * limit;
      // await db.close();
      // print('FROM DATABASE (${catsList.length}) : $catsList'); //Print Cats
      List<Cat> subList = [];
      if (catsList.length >= pagination) {
        subList = catsList.sublist(pagination, (pagination + limit));
      }

      return subList;
    } catch (e) {
      print(e);
      return [];
      // throw e;
    }
  }

  // A method that retrieves the faurite cats from the cats table.
  Future<List<Cat>> getFavCatsFromDb() async {
    // Get a reference to the database.
    // final db = await openDB();

    // Query the table for all the cats.
    try {
      final List<Map<String, dynamic>> maps =
          await db!.query('cats', where: 'isFav == 1');

      // Convert the List<Map<String, dynamic> into a List<Cat>.
      final List<Cat> catsList = List.generate(maps.length, (i) {
        return Cat(
          id: maps[i]['id'],
          url: maps[i]['url'],
          isFav: true,
        );
      });

      // await db.close();
      // print('FROM DATABASE (${catsList.length}) : $catsList'); //Print Cats

      return catsList;
    } catch (e) {
      print(e);
      return [];
      // throw e;
    }
  }

  // Function that updates cat's favourite status in the database
  Future<void> updateCatFavStatus(Cat cat) async {
    try {
      await db!.update(
        'cats',
        cat.toMap(),
        where: "id = ?",
        whereArgs: [cat.id],
      );
      print(
          'Favourite status for ${cat.id} in database was set to ${cat.isFav}');
    } catch (e) {
      print(e);
      // throw e;
    }
  }

  void close() async {
    db!.close();
  }
}
