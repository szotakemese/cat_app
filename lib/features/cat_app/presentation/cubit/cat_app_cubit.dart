import 'package:bloc/bloc.dart';
import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/cat_app/domain/entities/cat_app_status.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'cat_app_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CatAppCubit extends Cubit<CatAppState> {
  final GetNewCats getNewCats;
  final GetFavouriteCats getFavouriteCats;
  final GetCatFacts getCatFacts;
  final SaveCatsInDb saveCatsInDb;
  final SaveFactsInDb saveFactsInDb;
  final SetFav setFav;
  final DeleteFav deleteFav;
  final UpdateCatInDB updateCatInDB;

  CatAppCubit({
    required this.getNewCats,
    required this.getFavouriteCats,
    required this.getCatFacts,
    required this.saveCatsInDb,
    required this.saveFactsInDb,
    required this.setFav,
    required this.deleteFav,
    required this.updateCatInDB,
  }) : super(CatAppState());

  Future<void> loadAllCats(User user) async {
    emit(state.copyWith(
      status: CatAppStatus.initial,
    ));
    try {
      final Either<Failure, List<Cat>> catsResponse =
          await getNewCats(GetNewCatsParams(page: 0));
      final Either<Failure, List<Cat>> favouritesResponse =
          await getFavouriteCats(GetFavouriteCatsParams(userId: user.id));
      final Either<Failure, List<CatFact>> factsResponse =
          await getCatFacts(NoParams());

      catsResponse.fold(
          (failure) =>
              emit(state.copyWith(error: _mapFailureToMessage(failure))),
          (catsList) {
        favouritesResponse.fold(
            (failure) =>
                emit(state.copyWith(error: _mapFailureToMessage(failure))),
            (favouritesList) async {
          catsList.forEach((cat) {
            favouritesList.forEach((favCat) {
              if (favCat.id == cat.id) cat.isFav = true;
            });
          });
          await saveCatsInDb(SaveCatsInDbParams(cats: catsList));

          emit(state.copyWith(cats: catsList, favourites: favouritesList));
        });
      });

      factsResponse.fold(
          (failure) =>
              emit(state.copyWith(error: _mapFailureToMessage(failure))),
          (factsList) async {
        await saveFactsInDb(SaveFactsInDbParams(facts: factsList));
        emit(state.copyWith(facts: factsList));
      });

      emit(state.copyWith(
        status: CatAppStatus.succes,
        isLoading: false,
      ));
    } catch (err) {
      print(err);
      emit(state.copyWith(
        status: CatAppStatus.failure,
        error: err,
      ));
    }
  }

  Future<void> loadMoreCats(int page) async {
    if (state.isLoading)
      emit(state);
    else {
      try {
        emit(state.copyWith(isLoading: true));
        final Either<Failure, List<Cat>> moreCatsResponse =
            await getNewCats(GetNewCatsParams(page: page));
        final Either<Failure, List<CatFact>> moreFactsResponse =
            await getCatFacts(NoParams());

        List<Cat> cats = state.cats;
        List<CatFact> facts = state.facts;

        moreCatsResponse.fold(
            (failure) =>
                emit(state.copyWith(error: _mapFailureToMessage(failure))),
            (moreCatsList) async {
          if (moreCatsList.isEmpty)
            emit(state.copyWith(hasReachedMax: true, isLoading: true));
          else {
            moreCatsList.forEach((cat) {
              state.favourites.forEach((favCat) {
                if (favCat.id == cat.id) cat.isFav = true;
              });
            });
            await saveCatsInDb(SaveCatsInDbParams(cats: moreCatsList));
            cats.addAll(moreCatsList);
          }
        });

        moreFactsResponse.fold(
            (failure) =>
                emit(state.copyWith(error: _mapFailureToMessage(failure))),
            (moreFactsList) async {
          await saveFactsInDb(SaveFactsInDbParams(facts: moreFactsList));
          facts.addAll(moreFactsList);
        });

        emit(state.copyWith(
          status: CatAppStatus.succes,
          cats: cats,
          facts: facts,
          hasReachedMax: false,
          isLoading: false,
        ));

        print("${cats.length} cats are loaded");
      } catch (err) {
        emit(state.copyWith(
          status: CatAppStatus.failure,
          error: err,
        ));
      }
    }
  }

  Future<void> addCatToFavs(Cat cat, User user) async {
    try {
      await setFav(SetFavParams(catId: cat.id, userId: user.id));

      Cat currentCat = state.cats.firstWhere((element) => element.id == cat.id);
      currentCat.isFav = true;
      await updateCatInDB(UpdateCatInDBParams(cat: cat));

      List<Cat> favourites = [...state.favourites];
      favourites.add(currentCat);

      emit(state.copyWith(
        favourites: favourites,
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromFavs(Cat cat) async {
    try {
      List<Cat> cats = state.cats;
      List<Cat> favourites = [...state.favourites];

      final int catIndex = cats.indexWhere((element) => element.id == cat.id);
      if (catIndex != -1) {
        cats[catIndex].isFav = false;
      }

      await deleteFav(DeleteFavParams(favId: cat.id));
      favourites.removeWhere((element) => element.id == cat.id);

      await updateCatInDB(UpdateCatInDBParams(cat: cat));

      emit(state.copyWith(
        cats: cats,
        favourites: favourites,
      ));
    } catch (e) {
      print(e);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
