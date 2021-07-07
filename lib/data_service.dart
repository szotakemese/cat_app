import 'dart:convert';

import 'package:http/http.dart' as http;

import './models/models.dart';

class DataService {
  final catsListUrl = 'https://api.thecatapi.com/v1';
  final catFactsUrl = 'https://catfact.ninja';

  Future<List<Cat>> getAllCats() async {
    try {
      final response = await http.get(
        Uri.parse(catsListUrl + '/images/search?limit=50'),
        headers: {
          "x-api-key": "ca354f65-81b3-4f4b-86ce-f94ecc77c17c",
          "Content-Type": "application/json"
        },
      );
      final json = jsonDecode(response.body) as List;
      final cats = json.map((cat) => Cat.fromJson(cat)).toList();
      return cats;
    } catch (err) {
      throw err;
    }
  }

  Future<List<Cat>> getFavCats() async {
    try {
      final response = await http.get(
        Uri.parse(catsListUrl + '/favourites'),
        headers: {
          "x-api-key": "ca354f65-81b3-4f4b-86ce-f94ecc77c17c",
          "Content-Type": "application/json"
        },
      );
      final json = jsonDecode(response.body) as List;
      final cats = json.map((cat) => Cat.fromJson(cat)).toList();
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
      final json = jsonDecode(response.body);
      final catFact = CatFact.fromJson(json);
      return catFact;
    } catch (err) {
      throw err;
    }
  }
}
