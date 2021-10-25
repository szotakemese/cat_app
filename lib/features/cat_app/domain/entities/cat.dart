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
