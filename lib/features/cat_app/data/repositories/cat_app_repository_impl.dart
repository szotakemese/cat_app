import 'package:cat_app/core/error/exceptions.dart';
import 'package:cat_app/core/network/network_info.dart';
import 'package:cat_app/features/cat_app/data/datasources/datasources.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';

class CatAppRepositoryImpl implements CatAppRepository {
  final CatAppLocalDataSource localDataSource;
  final CatAppRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CatAppRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Cat>>> getNewCats(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCats = await remoteDataSource.getNewCats(page);
        return Right(remoteCats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCats = await localDataSource.getCatsFromDb(
            page, remoteDataSource.itemLimit);
        return Right(localCats);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Cat>>> getFavouriteCats(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFavs = await remoteDataSource.getFavCats(userId);
        return Right(remoteFavs);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFavs = await localDataSource.getFavCatsFromDb();
        return Right(localFavs);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CatFact>>> getCatFacts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFacts = await remoteDataSource.getFacts();
        return Right(remoteFacts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFacts = await localDataSource.getFactsFromDb();
        return Right(localFacts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> setFav(String catId, String userId) async {
    try {
      final setfav = await remoteDataSource.setFav(catId, userId);
      return (Right(setfav));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFav(String favId) async {
    try {
      final deletefav = await remoteDataSource.deleteFav(favId);
      return (Right(deletefav));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveCatsInDB(List<Cat> cats) async {
    try {
      final void saveData =
          cats.forEach((cat) async => await localDataSource.insertCatToDb(cat));
      return Right(saveData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFactsInDB(List<CatFact> facts) async {
    try {
      final void saveData = facts
          .forEach((fact) async => await localDataSource.insertFactToDb(fact));
      return Right(saveData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateCatInDB(Cat cat) async {
    try {
      final void updateCat = await localDataSource.updateCatFavStatus(cat);
      return Right(updateCat);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
