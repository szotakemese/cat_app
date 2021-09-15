import 'package:flutter_bloc/flutter_bloc.dart';

import 'cats_event.dart';
import 'cats_state.dart';

import 'package:cat_app/models/models.dart';

class AllCatsListBloc extends Bloc<CatsEvent, CatsState> {
  final dataService;
  AllCatsListBloc(this.dataService) : super(CatsState());

  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is LoadAllCatsEvent) {
      yield state.copyWith(
        status: CatsStatus.initial,
        // isLoaded: true,
      );
      try {
        final cats = await dataService.getAllCats(0);
        final favourites = await dataService.getFavCats(event.userId);
        yield state.copyWith(
          cats: cats,
          favourites: favourites,
          status: CatsStatus.succes,
          // isLoaded: false,
        );
        // yield LoadedCatsState(cats: cats);
      } catch (e) {
        yield state.copyWith(
          status: CatsStatus.failure,
          error: e,
        );
      }
    } else if (event is LoadMoreCats) {
      yield* mapLoadMoreCatsToState(event);
    } else if (event is CatUpdated) {
      yield* mapCatUpdatedToState(event);
    } else if (event is CatAddedToFavs) {
      yield* mapCatAddedToFavsToState(event);
    } else if (event is CatDeletedFromFavs) {
      yield* mapCatDeletedFromFavsToState(event);
    }
  }

  Stream<CatsState> mapLoadMoreCatsToState(LoadMoreCats event) async* {
    if (state.isLoading)
      yield state;
    else {
      try {
        yield state.copyWith(isLoading: true);
        final moreCats = await dataService.getAllCats(event.page);

        List<Cat> cats = state.cats + moreCats;
        yield moreCats.isEmpty
            ? state.copyWith(hasReachedMax: true, isLoading: true)
            : state.copyWith(
                status: CatsStatus.succes,
                cats: cats,
                hasReachedMax: false,
                isLoading: false,
              );
        print("${cats.length} cats are loaded");
      } catch (e) {
        print(e);
      }
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
      await dataService.setFav(catId, userId);

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
      Cat currentCat =
          state.favourites.firstWhere((element) => element.id == catId);

      List<Cat> favourites = state.favourites;

      await dataService.deleteFav(catId);
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
