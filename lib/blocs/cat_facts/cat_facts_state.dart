import 'package:cat_app/models/models.dart';

abstract class CatFactsState {}

class LoadingCatFactsState extends CatFactsState {}

class LoadedCatFactsState extends CatFactsState {
  CatFact catFact;
  LoadedCatFactsState({required this.catFact});
}

class FailedLoadCatFactsState extends CatFactsState {
  Object error;
  FailedLoadCatFactsState({required this.error});
}
