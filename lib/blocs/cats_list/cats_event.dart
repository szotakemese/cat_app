import 'package:cat_app/models/models.dart';

abstract class CatsEvent{
   const CatsEvent();

  List<Cat> get props => [];
}

class LoadAllCatsEvent extends CatsEvent{}

class RefreshAllCatsEvent extends CatsEvent{}

class LoadFavCatsEvent extends CatsEvent{}

class RefreshFavCatsEvent extends CatsEvent{}

class CatAddedToFavs extends CatsEvent{
  final String catId;
  final String userId;

  const CatAddedToFavs({required this.catId, required this.userId});
  
  @override
  String toString() => 'CatAddedToFavourites { addedCat: $catId }';
}

class CatDeletedFromFavs extends CatsEvent{
  final String catId;

  const CatDeletedFromFavs({required this.catId});

  @override
  String toString() => 'CatDeletedFromFavourites { deletedCat: $catId }';
}

class CatUpdated extends CatsEvent {
  final Cat cat;

  const CatUpdated(this.cat);

  @override
  List<Cat> get props => [cat];

  @override
  String toString() => 'CatUpdated { updatedCat: ${cat.id} }';
}