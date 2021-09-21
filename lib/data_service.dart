import 'dart:convert';
import 'package:cat_app/helpers/database.dart';
import 'package:http/http.dart' as http;

import './models/models.dart';

class DataService {
  final catsListUrl = 'https://api.thecatapi.com/v1';
  final catFactsUrl = 'https://catfact.ninja';
  final limit = 8;
  final order = 'asc';

  final DB dataBase;

  const DataService({required this.dataBase});

  Future<List<Cat>> getAllCats(int page) async {
    try {
      final response = await http.get(
        Uri.parse(catsListUrl +
            '/images/search?limit=$limit&page=$page&order=$order'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final allCats = jsonDecode(response.body) as List;
      final cats = allCats.map((cat) => Cat.allCatFromJson(cat)).toList();
      // print('All: $cats');

      return cats;
    } catch (err) {
      // throw err;
      print(err);
      final cats = await dataBase.getCatsFromDb(page, limit);
      
      return cats;
    }
  }

  Future<void> saveCatsInDB(cats) async {
    cats.forEach((cat) async =>
        await dataBase.insertCatToDb(cat)); //Save loaded Cats in Database
  }

  Future<List<Cat>> getFavCats(userId) async {
    try {
      final response = await http.get(
        Uri.parse(catsListUrl + '/favourites?sub_id=$userId'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final favCats = jsonDecode(response.body) as List;
      final cats = favCats.map((cat) => Cat.favCatFromJson(cat)).toList();
      // print('Favourites: $cats');
      return cats;
    } catch (err) {
      // throw err;
      print(err);
      final cats = await dataBase.getFavCatsFromDb();
      return cats;
    }
  }

  Future<List<CatFact>> getFacts() async {
    try {
      final response = await http.get(
        Uri.parse(catFactsUrl + '/facts?limit=$limit'),
      );
      final randomFacts = jsonDecode(response.body)['data'] as List;
      final catFacts =
          randomFacts.map((fact) => CatFact.fromJson(fact)).toList();
      return catFacts;
    } catch (err) {
      final catFacts = await dataBase.getFactsFromDb();
      return catFacts;
    }
  }

  Future<void> saveFactsInDB(facts) async {
    facts.forEach((fact) async =>
        await dataBase.insertFactToDb(fact)); //Save loaded facts in Database
  }

  Future<Favourite> setFav(cat, userId) async {
    print('ACTION');
    try {
      final response = await http.post(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          'image_id': cat.id,
          'sub_id': userId,
        }),
      );
      // print(await dataBase.getById(cat));

      return Favourite.fromJson(jsonDecode(response.body));
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateInDB(Cat cat) async {
    final dbStatus = await dataBase.updateCatFavStatus(cat);
    print(dbStatus);
  }

  Future<void> deleteFav(favId) async {
    try {
      final favsList = await http.get(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final favCats = jsonDecode(favsList.body) as List;
      final currentFavCat = favCats.firstWhere(
          (element) => element['image_id'] == favId,
          orElse: () => null);

      final currentFavCatId = currentFavCat['id'].toString();

      final response = await http.delete(
        Uri.parse(catsListUrl + '/favourites/$currentFavCatId'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final json = jsonDecode(response.body);
      print(json);

      print('DELETED : $favId ');
    } catch (err) {
      throw err;
    }
  }

  // Future<bool> checkConnection() async {
  //   bool hasConnection;

  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       hasConnection = true;
  //     } else {
  //       hasConnection = false;
  //     }
  //   } on SocketException catch (_) {
  //     hasConnection = false;
  //   }

  //   return hasConnection;
  // }
}
