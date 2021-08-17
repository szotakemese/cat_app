import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/data_service.dart';
import 'cats_event.dart';
import 'cats_state.dart';

import 'package:cat_app/models/models.dart';

class AllCatsListBloc extends Bloc<CatsEvent, CatsState> {
  final _dataService = DataService();

  AllCatsListBloc() : super(LoadingCatsState());

  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is LoadAllCatsEvent || event is RefreshAllCatsEvent) {
      yield LoadingCatsState();

      try {
        final cats = await _dataService.getAllCats();
        final favourites = await _dataService.getFavCats();
        yield LoadedCatsState(cats: cats, favourites: favourites);
        // yield LoadedCatsState(cats: cats);
      } catch (e) {
        yield FailedLoadCatsState(error: e);
      }
    } else if (event is CatUpdated) yield* mapCatUpdatedToState(event);
  }

  Stream<CatsState> mapCatUpdatedToState(CatUpdated event) async* {
    if (state is LoadedCatsState) {
      final List<Cat> updatedCats = (state as LoadedCatsState).cats.map((cat) {
        return cat.id == event.cat.id ? event.cat : cat;
      }).toList();
      final List<Cat> updatedFavourites =
          (state as LoadedCatsState).favourites.map((cat) {
        return cat.id == event.cat.id ? event.cat : cat;
      }).toList();
      yield LoadedCatsState(cats: updatedCats, favourites: updatedFavourites,);
      // yield LoadedCatsState(cats: updatedCats);
    }
  }
}

// class FavCatsListBloc extends AllCatsListBloc {
//   @override
//   Stream<CatsState> mapEventToState(CatsEvent event) async* {
//     if (event is LoadFavCatsEvent || event is RefreshFavCatsEvent) {
//       yield LoadingCatsState();

//       try {
//         final cats = await _dataService.getFavCats();
//         yield LoadedCatsState(cats: cats);
//       } catch (e) {
//         yield FailedLoadCatsState(error: e);
//       }
//     } else if (event is CatUpdated) yield* mapCatUpdatedToState(event);
//   }
// }
