import 'package:cat_app/models/models.dart';

class CatsState {
  final List<Cat> cats;
  final List<Cat> favourites;
  final bool isLoading;
  final dynamic error;

  CatsState({
    this.cats = const <Cat>[],
    this.favourites = const <Cat>[],
    this.isLoading = false,
    this.error,
  });

  CatsState copyWith({
    final List<Cat>? cats,
    final List<Cat>? favourites,
    final bool? isLoading,
    final dynamic error,
  }) {
    return CatsState(
      cats: cats ?? this.cats,
      favourites: favourites ?? this.favourites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
