import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Cat extends Equatable {
  final String id;
  final String url;
  bool isFav;
  Cat({
    required this.id,
    required this.url,
    this.isFav = false,
  });

  factory Cat.allCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['id'],
        url: json['url'],
      );

  factory Cat.favCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['image']['id'],
        url: json['image']['url'],
        isFav: true,
      );

  factory Cat.allCatsFromDB(Map<String, dynamic> dbData) => Cat(
        id: dbData['id'],
        url: dbData['url'],
        isFav: dbData['isFav'] == 1,
      );
  
  factory Cat.favCatsFromDB(Map<String, dynamic> dbData) => Cat(
        id: dbData['id'],
        url: dbData['url'],
        isFav: true,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'isFav': isFav ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Cat{id: $id, url: $url, isFav: $isFav}';
  }

  @override
  List<Object> get props => [id, url, isFav,] ;
}
