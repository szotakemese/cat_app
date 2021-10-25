part of 'cat_app_cubit.dart';

class CatAppState extends Equatable {
  final List<Cat> cats;
  final List<Cat> favourites;
  final List<CatFact> facts;
  final bool isLoading;
  final CatAppStatus status;
  final bool hasReachedMax;
  final dynamic error;

  const CatAppState({
    this.cats = const <Cat>[],
    this.favourites = const <Cat>[],
    this.facts = const <CatFact>[],
    this.isLoading = false,
    this.status = CatAppStatus.initial,
    this.hasReachedMax = false,
    this.error,
  });

  bool isFaved(final Cat cat) =>
      favourites.indexWhere((element) => element.id == cat.id) >= 0;

  CatAppState copyWith({
    final List<Cat>? cats,
    final List<Cat>? favourites,
    final List<CatFact>? facts,
    final bool? isLoading,
    final CatAppStatus? status,
    final bool? hasReachedMax,
    final dynamic error,
  }) {
    return CatAppState(
      cats: cats ?? this.cats,
      favourites: favourites ?? this.favourites,
      facts: facts ?? this.facts,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        cats,
        favourites,
        facts,
        isLoading,
        status,
        hasReachedMax,
        error,
      ];
}
