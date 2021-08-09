import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/data_service.dart';
import 'cat_facts_event.dart';
import 'cat_facts_state.dart';

class CatFactsBloc extends Bloc<CatFactsEvent, CatFactsState> {
  final _dataService = DataService();

  CatFactsBloc() : super(LoadingCatFactsState());

  @override
  Stream<CatFactsState> mapEventToState(CatFactsEvent event) async*{
    if (event is LoadCatFactsEvent) {
      yield LoadingCatFactsState();

      try{
        final catFact = await _dataService.getFact();
        yield LoadedCatFactsState(catFact: catFact);
      } catch (e) {
        yield FailedLoadCatFactsState(error: e);
      }
    }
  }
}