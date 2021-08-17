import 'package:cat_app/models/models.dart';

abstract class CatsState {}

class LoadingCatsState extends CatsState {}

class LoadedCatsState extends CatsState {
  List<Cat> cats;
  List<Cat> favourites;
  // LoadedCatsState({required this.cats});
  LoadedCatsState({ required this.cats, required this.favourites,});

  // List<Cat> get favourites => cats.where((element) => element.isFav).toList();
}

class FailedLoadCatsState extends CatsState {
  Object error;
  FailedLoadCatsState({required this.error});
}
