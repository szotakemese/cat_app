import 'package:cat_app/models/models.dart';

abstract class CatsEvent{
   const CatsEvent();

  List<Cat> get props => [];
}

class LoadAllCatsEvent extends CatsEvent{}

class RefreshAllCatsEvent extends CatsEvent{}

class LoadFavCatsEvent extends CatsEvent{}

class RefreshFavCatsEvent extends CatsEvent{}

class CatUpdated extends CatsEvent {
  final Cat cat;

  const CatUpdated(this.cat);

  @override
  List<Cat> get props => [cat];

  @override
  String toString() => 'CatUpdated { updatedCat: ${cat.id} }';
}