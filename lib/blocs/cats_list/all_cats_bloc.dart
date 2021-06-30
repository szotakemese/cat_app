import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_service.dart';
import 'cats_event.dart';
import 'cats_state.dart';

class AllCatsBloc extends Bloc<CatsEvent, CatsState> {
  final _dataService = DataService();

  AllCatsBloc() : super(LoadingCatsState());

  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async*{
    if (event is LoadCatsEvent || event is PullToRefreshEvent) {
      yield LoadingCatsState();

      try{
        final cats = await _dataService.getAllCats();
        yield LoadedCatsState(cats: cats);
      } catch (e) {
        yield FailedLoadCatsState(error: e);
      }
    }
  }
}