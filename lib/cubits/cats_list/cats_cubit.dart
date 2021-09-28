import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/helpers/helpers.dart';
import 'cats_list.dart';

import 'package:cat_app/models/models.dart';

class CatsCubit extends Cubit<CatsState> {
  final DataService dataService;
  CatsCubit(this.dataService) : super(CatsState());

  Future<void> loadAllCats(User user) async {
    emit(state.copyWith(
      status: CatsStatus.initial,
    ));
    try {
      final List<Cat> cats = await dataService.getAllCats(0);
      final List<Cat> favourites = await dataService.getFavCats(user.id);
      final List<CatFact> facts = await dataService.getFacts();
      cats.forEach((cat) {
        favourites.forEach((favCat) {
          if (favCat.id == cat.id) cat.isFav = true;
        });
      });
      await dataService.saveCatsInDB(cats);
      await dataService.saveFactsInDB(facts);
      emit(state.copyWith(
        cats: cats,
        favourites: favourites,
        facts: facts,
        status: CatsStatus.succes,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CatsStatus.failure,
        error: e,
      ));
    }
  }

  Future<void> loadMoreCats(int page) async {
    if (state.isLoading)
      emit(state);
    else {
      try {
        emit(state.copyWith(isLoading: true));
        final List<Cat> moreCats = await dataService.getAllCats(page);
        final List<CatFact> moreFacts = await dataService.getFacts();
        moreCats.forEach((cat) {
          state.favourites.forEach((favCat) {
            if (favCat.id == cat.id) cat.isFav = true;
          });
        });

        List<Cat> cats = state.cats + moreCats;
        List<CatFact> facts = state.facts + moreFacts;

        await dataService.saveCatsInDB(moreCats);
        emit(moreCats.isEmpty
            ? state.copyWith(hasReachedMax: true, isLoading: true)
            : state.copyWith(
                status: CatsStatus.succes,
                cats: cats,
                facts: facts,
                hasReachedMax: false,
                isLoading: false,
              ));
        print("${cats.length} cats are loaded");
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> addCatToFavs(Cat cat, User user) async {
    try {
      await dataService.setFav(cat, user.id);

      Cat currentCat = state.cats.firstWhere((element) => element.id == cat.id);
      currentCat.isFav = true;
      await dataService.updateInDB(currentCat);

      List<Cat> favourites = state.favourites;
      favourites.add(currentCat);

      emit(state.copyWith(favourites: favourites));
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromFavs(Cat cat) async {
    try {
      List<Cat> cats = state.cats;
      List<Cat> favourites = state.favourites;

      final int catIndex = cats.indexWhere((element) => element.id == cat.id);
      if (catIndex != -1) {
        cats[catIndex].isFav = false;
      }

      await dataService.deleteFav(cat.id);
      favourites.removeWhere((element) => element.id == cat.id);

      await dataService.updateInDB(Cat(id: cat.id, url: cat.url, isFav: false));

      emit(state.copyWith(
        cats: cats,
        favourites: favourites,
      ));
    } catch (e) {
      print(e);
    }
  }
}
