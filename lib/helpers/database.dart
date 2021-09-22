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
        db.execute(
          'CREATE TABLE cats(id TEXT PRIMARY KEY, url TEXT, isFav BIT)',
        );
        db.execute(
          'CREATE TABLE facts(fact TEXT PRIMARY KEY, length INTEGER)',
        );
      },
      version: 1,
    );
    print('DB opened');
  }

  Future<void> insertCatToDb(Cat cat) async {
    try {
      await db!.insert(
        'cats',
        cat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> insertFactToDb(CatFact fact) async {
    try {
      await db!.insert(
        'facts',
        fact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<CatFact>> getFactsFromDb() async {
    try {
      final List<Map<String, dynamic>> maps = await db!.query('facts');
      final List<CatFact> factsList = List.generate(maps.length, (i) {
        return CatFact(
          fact: maps[i]['fact'],
          length: maps[i]['length'],
        );
      });

      return factsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Cat>> getCatsFromDb(int page, int limit) async {
    try {
      final List<Map<String, dynamic>> maps = await db!.query(
        'cats',
        orderBy: "id ASC",
        limit: limit,
        offset: page * limit,
      );

      final List<Cat> catsList = List.generate(maps.length, (i) {
        return Cat(
          id: maps[i]['id'],
          url: maps[i]['url'],
          isFav: maps[i]['isFav'] == 1,
        );
      });

      List<String> onlyId = [];
      catsList.forEach((e) => onlyId.add(e.id));

      print('FROM DATABASE (${catsList.length}) : $onlyId');

      return catsList;
    } catch (e) {
      print(e);
      return [];
    }
  }
  
  Future<List<Cat>> getFavCatsFromDb() async {
    try {
      final List<Map<String, dynamic>> maps =
          await db!.query('cats', where: 'isFav == 1');

      final List<Cat> catsList = List.generate(maps.length, (i) {
        return Cat(
          id: maps[i]['id'],
          url: maps[i]['url'],
          isFav: true,
        );
      });

      return catsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> updateCatFavStatus(Cat cat) async {
    try {
      return await db!.update(
        'cats',
        cat.toMap(),
        where: "id = ?",
        whereArgs: [cat.id],
      );
    } catch (e) {
      print(e);
      return 0;
    }
  }

  void close() async {
    db!.close();
  }
}
