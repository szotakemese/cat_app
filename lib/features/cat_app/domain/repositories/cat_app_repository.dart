import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class CatAppRepository {
  Future<Either<Failure, List<Cat>>> getAllCats(int page);
  Future<Either<Failure, List<Cat>>> getFavouriteCats(String userId);
  Future<Either<Failure, List<CatFact>>> getCatFacts();
  Future<void> setFav(String catId, String userId);
  Future<void> deleteFav(String favId);
}
