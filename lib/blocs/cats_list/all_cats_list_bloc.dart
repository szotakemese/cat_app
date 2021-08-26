import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/data_service.dart';
import 'cats_event.dart';
import 'cats_state.dart';

import 'package:cat_app/models/models.dart';

class AllCatsListBloc extends Bloc<CatsEvent, CatsState> {
  final _dataService = DataService();

  AllCatsListBloc() : super(CatsState());

  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is LoadAllCatsEvent || event is RefreshAllCatsEvent) {
      yield state.copyWith(isLoading: true);

      try {
        final cats = await _dataService.getAllCats();
        final favourites = await _dataService.getFavCats();
        yield state.copyWith(
            cats: cats, favourites: favourites, isLoading: false);
        // yield LoadedCatsState(cats: cats);
      } catch (e) {
        yield state.copyWith(error: e);
      }
    } else if (event is CatUpdated) {
      yield* mapCatUpdatedToState(event);
    } else if (event is CatAddedToFavs) {
      yield* mapCatAddedToFavsToState(event);
    } else if (event is CatDeletedFromFavs) {
      yield* mapCatDeletedFromFavsToState(event);
    }
  }

  Stream<CatsState> mapCatUpdatedToState(CatUpdated event) async* {
    final List<Cat> updatedCats = state.cats.map((cat) {
      return cat.id == event.cat.id ? event.cat : cat;
    }).toList();
    final List<Cat> updatedFavourites = state.favourites.map((cat) {
      return cat.id == event.cat.id ? event.cat : cat;
    }).toList();
    yield state.copyWith(
      cats: updatedCats,
      favourites: updatedFavourites,
    );
  }

  Stream<CatsState> mapCatAddedToFavsToState(CatAddedToFavs event) async* {
    try {
      final catId = event.catId;
      final userId = event.userId;
      await _dataService.setFav(catId, userId);

      Cat currentCat = state.cats.firstWhere((element) => element.id == catId);

      List<Cat> favourites = state.favourites;
      favourites.add(currentCat);

      yield state.copyWith(favourites: favourites);
    } catch (e) {
      print(e);
    }
  }

  Stream<CatsState> mapCatDeletedFromFavsToState(
      CatDeletedFromFavs event) async* {
    try {
      final catId = event.catId;
      await _dataService.deleteFav(catId);

      Cat currentCat = state.cats.firstWhere((element) => element.id == catId);

      List<Cat> favourites = state.favourites;

      favourites.remove(currentCat);

      yield state.copyWith(favourites: favourites);
    } catch (e) {
      print(e);
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
