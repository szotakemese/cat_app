import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class CatAppRepository {
  Future<Either<Failure, List<Cat>>> getNewCats(int page);
  Future<Either<Failure, List<Cat>>> getFavouriteCats(String userId);
  Future<Either<Failure, List<CatFact>>> getCatFacts();
  Future<Either<Failure, void>> setFav(String catId, String userId);
  Future<Either<Failure, void>> deleteFav(String favId);
  Future<Either<Failure, void>> saveCatsInDB(List<Cat> cats);
  Future<Either<Failure, void>> saveFactsInDB(List<CatFact> facts);
  Future<Either<Failure, void>> updateCatInDB(Cat cat);
}
