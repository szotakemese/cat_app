import 'dart:convert';
import 'package:cat_app/helpers/database.dart';
import 'package:http/http.dart' as http;

import 'package:cat_app/features/cat_app/domain/entities/entities.dart';

class DataService {
  final String catsListUrl = 'https://api.thecatapi.com/v1';
  final String catFactsUrl = 'https://catfact.ninja';
  final int limit = 8;
  final String order = 'asc';

  final DB dataBase;

  const DataService({required this.dataBase});

  Future<List<Cat>> getAllCats(int page) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(catsListUrl +
            '/images/search?limit=$limit&page=$page&order=$order'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final List<dynamic> allCats = jsonDecode(response.body) as List;
      final List<Cat> cats =
          allCats.map((cat) => Cat.allCatFromJson(cat)).toList();

      return cats;
    } catch (err) {
      print(err);
      final List<Cat> cats = await dataBase.getCatsFromDb(page, limit);

      return cats;
    }
  }

  Future<void> saveCatsInDB(List<Cat> cats) async {
    cats.forEach((cat) async => await dataBase.insertCatToDb(cat));
  }

  Future<List<Cat>> getFavCats(String userId) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(catsListUrl + '/favourites?sub_id=$userId'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final List<dynamic> favCats = jsonDecode(response.body) as List;
      final List<Cat> cats =
          favCats.map((cat) => Cat.favCatFromJson(cat)).toList();
      return cats;
    } catch (err) {
      print(err);
      final List<Cat> cats = await dataBase.getFavCatsFromDb();
      return cats;
    }
  }

  Future<List<CatFact>> getFacts() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(catFactsUrl + '/facts?limit=$limit'),
      );
      final List<dynamic> randomFacts =
          jsonDecode(response.body)['data'] as List;
      final List<CatFact> catFacts =
          randomFacts.map((fact) => CatFact.fromJson(fact)).toList();
      return catFacts;
    } catch (err) {
      final List<CatFact> catFacts = await dataBase.getFactsFromDb();
      return catFacts;
    }
  }

  Future<void> saveFactsInDB(List<CatFact> facts) async {
    facts.forEach((fact) async => await dataBase.insertFactToDb(fact));
  }

  Future<void> setFav(catId, userId) async {
    print('ACTION');
    try {
      await http.post(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          'image_id': catId,
          'sub_id': userId,
        }),
      );
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateInDB(Cat cat) async {
    await dataBase.updateCatFavStatus(cat);
  }

  Future<void> deleteFav(favId) async {
    try {
      final http.Response favsList = await http.get(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final List<dynamic> favCats = jsonDecode(favsList.body) as List;
      final dynamic currentFavCat = favCats.firstWhere(
          (element) => element['image_id'] == favId,
          orElse: () => null);

      final String currentFavCatId = currentFavCat['id'].toString();

      final http.Response response = await http.delete(
        Uri.parse(catsListUrl + '/favourites/$currentFavCatId'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final dynamic json = jsonDecode(response.body);
      print(json);

      print('DELETED : $favId ');
    } catch (err) {
      throw err;
    }
  }
}
