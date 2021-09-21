import 'package:cat_app/models/models.dart';

abstract class CatsEvent{
   const CatsEvent();

  List<Cat> get props => [];
}

class LoadAllCatsEvent extends CatsEvent{
  final String userId;

  const LoadAllCatsEvent(this.userId);
}

class LoadMoreCats extends CatsEvent{
  final int page;

  const LoadMoreCats(this.page);
}

class CatAddedToFavs extends CatsEvent{
  final Cat cat;
  final String userId;

  const CatAddedToFavs({required this.cat, required this.userId});
  
  @override
  String toString() => 'CatAddedToFavourites { addedCat: ${cat.id} }';
}

class CatDeletedFromFavs extends CatsEvent{
  final Cat cat;

  const CatDeletedFromFavs({required this.cat});

  @override
  String toString() => 'CatDeletedFromFavourites { deletedCat: ${cat.id} }';
}
