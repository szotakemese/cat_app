import 'dart:convert';
import 'package:cat_app/core/error/exceptions.dart';
import 'package:cat_app/features/cat_app/data/models/cat_fact_model.dart';
import 'package:cat_app/features/cat_app/data/models/cat_model.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:http/http.dart' as http;

abstract class CatAppRemoteDataSource {
  int get itemLimit;

  Future<List<Cat>> getNewCats(int page);

  Future<List<Cat>> getFavCats(String userId);

  Future<List<CatFact>> getFacts();

  Future<void> setFav(catId, userId);

  Future<void> deleteFav(favId);
}

class CatAppRemoteDataSourceImpl implements CatAppRemoteDataSource {
  final http.Client client;

  final String catsListUrl = 'https://api.thecatapi.com/v1';
  final String catFactsUrl = 'https://catfact.ninja';
  final int limit = 8;
  final String order = 'asc';

  final Map<String, String> headers = {
    "x-api-key": "44ae0849-4728-4144-a8ac-223564215798",
    "Content-Type": "application/json"
  };

  CatAppRemoteDataSourceImpl({required this.client});

  @override
  int get itemLimit => limit;

  @override
  Future<List<Cat>> getNewCats(int page) async {
    try {
      final http.Response response = await client.get(
        Uri.parse(catsListUrl +
            '/images/search?limit=$limit&page=$page&order=$order'),
        headers: headers,
      );
      final List<dynamic> newCats = jsonDecode(response.body) as List;
      final List<Cat> cats =
          newCats.map((cat) => CatModel.allCatFromJson(cat)).toList();
      return cats;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<List<Cat>> getFavCats(String userId) async {
    try {
      final http.Response response = await client.get(
        Uri.parse(catsListUrl + '/favourites?sub_id=$userId'),
        headers: headers,
      );
      final List<dynamic> favCats = jsonDecode(response.body) as List;
      final List<Cat> cats =
          favCats.map((cat) => CatModel.favCatFromJson(cat)).toList();
      return cats;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<List<CatFact>> getFacts() async {
    try {
      final http.Response response = await client.get(
        Uri.parse(catFactsUrl + '/facts?limit=$limit'),
      );
      final List<dynamic> randomFacts =
          jsonDecode(response.body)['data'] as List;
      final List<CatFact> catFacts =
          randomFacts.map((fact) => CatFactModel.fromMap(fact)).toList();
      return catFacts;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<void> setFav(catId, userId) async {
    try {
      await client.post(
        Uri.parse(catsListUrl + '/favourites'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'image_id': catId,
          'sub_id': userId,
        }),
      );

      print('Like: $catId ');
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteFav(favId) async {
    try {
      final http.Response favsList = await client.get(
        Uri.parse(catsListUrl + '/favourites'),
        headers: headers,
      );
      final List<dynamic> favCats = jsonDecode(favsList.body) as List;
      final dynamic currentFavCat = favCats.firstWhere(
          (element) => element['image_id'] == favId,
          orElse: () => null);

      final String currentFavCatId = currentFavCat['id'].toString();

      // final http.Response response = 
      await client.delete(
        Uri.parse(catsListUrl + '/favourites/$currentFavCatId'),
        headers: headers,
      );

      // print(jsonDecode(response.body));

      print('Remove Like: $favId ');
    } on Exception {
      throw ServerException();
    }
  }
}
