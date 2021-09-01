import 'dart:convert';
import 'package:cat_app/helpers/database.dart';
import 'package:http/http.dart' as http;

import './models/models.dart';

class DataService {
  final catsListUrl = 'https://api.thecatapi.com/v1';
  final catFactsUrl = 'https://catfact.ninja';

  final DB dataBase;

  const DataService({required this.dataBase});

  Future<List<Cat>> getAllCats() async {
    try {
      final response = await http.get(
        Uri.parse(catsListUrl + '/images/search?limit=15'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
      );
      final allCats = jsonDecode(response.body) as List;
      // print('All: $allCats');
      final cats = allCats.map((cat) => Cat.allCatFromJson(cat)).toList();

      // cats.map((cat) async => await dataBase.insertCatToDb(cat));
      cats.forEach((cat) async => await dataBase.insertCatToDb(cat));
      await dataBase.getCatsFromDb();

      return cats;
    } catch (err) {
      throw err;
    }
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
      // print('Favourites: $favCats');
      final cats = favCats.map((cat) => Cat.favCatFromJson(cat)).toList();
      return cats;
    } catch (err) {
      throw err;
    }
  }

  Future<CatFact> getFact() async {
    try {
      final response = await http.get(
        Uri.parse(catFactsUrl + '/fact'),
      );
      final randomFact = jsonDecode(response.body);
      final catFact = CatFact.fromJson(randomFact);
      return catFact;
    } catch (err) {
      throw err;
    }
  }

  // Future<List<CatFact>> getFacts() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(catFactsUrl + '/facts?limit=20'),
  //     );
  //     final randomFacts = jsonDecode(response.body) as List;
  //     print('Facts: $randomFacts');
  //     final catFacts = randomFacts.map((fact) => CatFact.fromJson(fact)).toList();
  //     return catFacts;
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  Future<Favourite> setFav(imageId, subId) async {
    try {
      final response = await http.post(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          'image_id': imageId,
          'sub_id': subId,
        }),
      );
      return Favourite.fromJson(jsonDecode(response.body));
    } catch (err) {
      throw err;
    }
  }

  // Future<Favourite> deleteFav(favId) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse(catsListUrl + '/favourites/$favId'),
  //       headers: {
  //         "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
  //         "Content-Type": "application/json"
  //       },
  //     );
  //     return Favourite.fromJson(jsonDecode(response.body));
  //   } catch (err) {
  //     throw err;
  //   }
  // }
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

  // Future<List<dynamic>> favsList() async {
  //   try {
  //     final favsList = await http.get(
  //       Uri.parse(catsListUrl + '/favourites'),
  //       headers: {
  //         "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
  //         "Content-Type": "application/json"
  //       },
  //     );
  //     final favCats = jsonDecode(favsList.body) as List;
  //     return favCats;
  //   } catch (err) {
  //     throw err;
  //   }
  // }
}
