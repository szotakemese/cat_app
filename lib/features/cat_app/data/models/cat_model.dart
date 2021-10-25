import 'package:cat_app/features/cat_app/domain/entities/cat.dart';

// ignore: must_be_immutable
class CatModel extends Cat {
  CatModel({
    required String id,
    required String url,
    bool isFav = false,
  }) : super(
          id: id,
          url: url,
          isFav: isFav,
        );

  factory CatModel.allCatFromJson(Map<String, dynamic> json) => CatModel(
        id: json['id'],
        url: json['url'],
      );

  factory CatModel.favCatFromJson(Map<String, dynamic> json) => CatModel(
        id: json['image']['id'],
        url: json['image']['url'],
        isFav: true,
      );

  factory CatModel.allCatsFromDB(Map<String, dynamic> dbData) => CatModel(
        id: dbData['id'],
        url: dbData['url'],
        isFav: dbData['isFav'] == 1,
      );

  factory CatModel.favCatsFromDB(Map<String, dynamic> dbData) => CatModel(
        id: dbData['id'],
        url: dbData['url'],
        isFav: true,
      );
}
