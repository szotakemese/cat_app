import 'package:cat_app/core/error/exceptions.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class CatAppLocalDataSource {
  Future<void> openDB();

  Future<void> insertCatToDb(Cat cat);

  Future<void> insertFactToDb(CatFact fact);

  Future<List<Cat>> getCatsFromDb(int page, int limit);

  Future<List<Cat>> getFavCatsFromDb();

  Future<List<CatFact>> getFactsFromDb();

  Future<void> updateCatFavStatus(Cat cat);

  Future<void> closeDB();
}

class CatAppLocalDataSourceImpl implements CatAppLocalDataSource {
  Database? db;

  @override
  Future<void> openDB() async {
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

  @override
  Future<void> insertCatToDb(Cat cat) async {
    try {
      await db!.insert(
        'cats',
        cat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> insertFactToDb(CatFact fact) async {
    try {
      await db!.insert(
        'facts',
        fact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<List<Cat>> getCatsFromDb(int page, int limit) async {
    try {
      final List<Map<String, dynamic>> maps = await db!.query(
        'cats',
        orderBy: "id ASC",
        limit: limit,
        offset: page * limit,
      );

      final List<Cat> catsList =
          maps.map((cat) => Cat.allCatsFromDB(cat)).toList();

      List<String> onlyId = [];
      catsList.forEach((e) => onlyId.add(e.id));

      print('FROM DATABASE (${catsList.length}) : $onlyId');

      return catsList;
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<List<Cat>> getFavCatsFromDb() async {
    try {
      final List<Map<String, dynamic>> maps =
          await db!.query('cats', where: 'isFav == 1');

      final List<Cat> catsList =
          maps.map((cat) => Cat.favCatsFromDB(cat)).toList();

      return catsList;
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<List<CatFact>> getFactsFromDb() async {
    try {
      final List<Map<String, dynamic>> maps = await db!.query('facts');

      final List<CatFact> factsList =
          maps.map((fact) => CatFact.fromMap(fact)).toList();

      return factsList;
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> updateCatFavStatus(Cat cat) async {
    try {
      await db!.update(
        'cats',
        cat.toMap(),
        where: "id = ?",
        whereArgs: [cat.id],
      );
    } on Exception {
      throw CacheException();
    }
  }

  Future<void> closeDB() async {
    db!.close();
    print('DB closed');
  }
}
