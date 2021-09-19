import 'package:cat_app/models/models.dart';

enum CatsStatus { initial, loading, succes, failure }

class CatsState {
  final List<Cat> cats;
  final List<Cat> favourites;
  final List<CatFact> facts;
  final bool isLoading;
  final CatsStatus status;
  final bool hasReachedMax;
  final dynamic error;

  CatsState({
    this.cats = const <Cat>[],
    this.favourites = const <Cat>[],
    this.facts = const <CatFact>[],
    this.isLoading = false,
    this.status = CatsStatus.initial,
    this.hasReachedMax = false,
    this.error,
  });

  CatsState copyWith({
    final List<Cat>? cats,
    final List<Cat>? favourites,
    final List<CatFact>? facts,
    final bool? isLoading,
    final CatsStatus? status,
    final bool? hasReachedMax,
    final dynamic error,
  }) {
    return CatsState(
      cats: cats ?? this.cats,
      favourites: favourites ?? this.favourites,
      facts: facts ?? this.facts,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }
}
