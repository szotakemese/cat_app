import 'package:cat_app/models/cat.dart';

abstract class CatsState {}

class LoadingCatsState extends CatsState {}

class LoadedCatsState extends CatsState {
  List<Cat> cats;
  LoadedCatsState({required this.cats});
}

class FailedLoadCatsState extends CatsState {
  Object error;
  FailedLoadCatsState({required this.error});
}
