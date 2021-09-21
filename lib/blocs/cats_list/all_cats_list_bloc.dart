import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_service.dart';
import 'cats_event.dart';
import 'cats_state.dart';

import 'package:cat_app/models/models.dart';

class AllCatsListBloc extends Bloc<CatsEvent, CatsState> {
  final DataService dataService;
  AllCatsListBloc(this.dataService) : super(CatsState());

  bool isOnline = false;
  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is LoadAllCatsEvent) {
      yield state.copyWith(
        status: CatsStatus.initial,
      );
      try {
        final cats = await dataService.getAllCats(0);
        final favourites = await dataService.getFavCats(event.userId);
        final facts = await dataService.getFacts();
        cats.forEach((cat) {
          favourites.forEach((favCat) {
            if (favCat.id == cat.id) cat.isFav = true;
          });
        });
        await dataService.saveCatsInDB(cats);
        await dataService.saveFactsInDB(facts);
        yield state.copyWith(
          cats: cats,
          favourites: favourites,
          facts: facts,
          status: CatsStatus.succes,
          isLoading: false,
        );
      } catch (e) {
        yield state.copyWith(
          status: CatsStatus.failure,
          error: e,
        );
      }
    } else if (event is LoadMoreCats) {
      yield* mapLoadMoreCatsToState(event);
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
        final moreFacts = await dataService.getFacts();
        moreCats.forEach((cat) {
          state.favourites.forEach((favCat) {
            if (favCat.id == cat.id) cat.isFav = true;
          });
        });

        List<Cat> cats = state.cats + moreCats;
        List<CatFact> facts = state.facts + moreFacts;

        await dataService.saveCatsInDB(moreCats);
        yield moreCats.isEmpty
            ? state.copyWith(hasReachedMax: true, isLoading: true)
            : state.copyWith(
                status: CatsStatus.succes,
                cats: cats,
                facts: facts,
                hasReachedMax: false,
                isLoading: false,
              );
        print("${cats.length} cats are loaded");
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<CatsState> mapCatAddedToFavsToState(CatAddedToFavs event) async* {
    try {
      final cat = event.cat;
      final userId = event.userId;
      await dataService.setFav(cat, userId);

      Cat currentCat = state.cats.firstWhere((element) => element.id == cat.id);
      currentCat.isFav = true;
      await dataService.updateInDB(currentCat);

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
      List<Cat> cats = state.cats;
      List<Cat> favourites = state.favourites;

      final catIndex = cats.indexWhere((element) => element.id == event.cat.id);
      if (catIndex != -1) {
        cats[catIndex].isFav = false;
      }

      await dataService.deleteFav(event.cat.id);
      favourites.removeWhere((element) => element.id == event.cat.id);

      await dataService
          .updateInDB(Cat(id: event.cat.id, url: event.cat.url, isFav: false));

      yield state.copyWith(
        cats: cats,
        favourites: favourites,
      );
    } catch (e) {
      print(e);
    }
  }
}
