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

  factory CatModel.allCatFromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      url: json['url'],
    );
  }

  factory CatModel.favCatFromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['image']['id'],
      url: json['image']['url'],
      isFav: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'isFav': isFav ? 1 : 0,
    };
  }
}
