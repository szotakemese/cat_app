import 'package:flutter_bloc/flutter_bloc.dart';

import 'cat_facts_event.dart';
import 'cat_facts_state.dart';

class CatFactsBloc extends Bloc<CatFactsEvent, CatFactsState> {
  final dataService;

  CatFactsBloc(this.dataService) : super(LoadingCatFactsState());

  @override
  Stream<CatFactsState> mapEventToState(CatFactsEvent event) async*{
    if (event is LoadCatFactsEvent) {
      yield LoadingCatFactsState();

      try{
        final catFact = await dataService.getFact();
        yield LoadedCatFactsState(catFact: catFact);
      } catch (e) {
        yield FailedLoadCatFactsState(error: e);
      }
    }
  }
}