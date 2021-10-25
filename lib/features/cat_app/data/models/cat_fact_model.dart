import 'package:cat_app/features/cat_app/domain/entities/cat_fact.dart';

class CatFactModel extends CatFact {
  CatFactModel({
    required String fact,
    required int length,
  }) : super(
          fact: fact,
          length: length,
        );

  factory CatFactModel.allCatFactFromJson(Map<String, dynamic> json) {
    return CatFactModel(
      fact: json['fact'],
      length: json['length'],
    );
  }
  factory CatFactModel.fromMap(Map<String, dynamic> json) => CatFactModel(
        fact: json['fact'],
        length: json['length'],
      );
}
