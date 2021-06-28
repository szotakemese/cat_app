import 'dart:convert';

import 'package:http/http.dart' as http;

import './models/cat.dart';

class DataService {
  final myUrl = 'https://api.thecatapi.com/v1';

  Future<List<Cat>> getAllCats() async {
    try{
      final response = await http.get(
      Uri.parse(myUrl + '/images/search?limit=100'),
      headers: {"x-api-key": "ca354f65-81b3-4f4b-86ce-f94ecc77c17c", "Content-Type": "application/json"},
    );
    final json = jsonDecode(response.body) as List;
    final cats = json.map((cat) => Cat.fromJson(cat)).toList();
    return cats;
    } catch (err) {
      throw err;
    }
  }

  Future<List<Cat>> getFavCats() async {
    try{
      final response = await http.get(
      Uri.parse(myUrl + '/favourites'),
      headers: {"x-api-key": "ca354f65-81b3-4f4b-86ce-f94ecc77c17c", "Content-Type": "application/json"},
    );
    final json = jsonDecode(response.body) as List;
    final cats = json.map((cat) => Cat.fromJson(cat)).toList();
    return cats;
    } catch (err) {
      throw err;
    }
  }

}
