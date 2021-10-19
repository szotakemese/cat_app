import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetFavouriteCats implements UseCase<List<Cat>, GetFavouriteCatsParams> {
  final CatAppRepository catAppRepository;

  GetFavouriteCats(this.catAppRepository);

  @override
  Future<Either<Failure, List<Cat>>> call(GetFavouriteCatsParams params) async {
    return await catAppRepository.getFavouriteCats(params.userId);
  }
}

class GetFavouriteCatsParams extends Equatable {
  final String userId;

  GetFavouriteCatsParams({required this.userId});

  @override
  List<Object> get props => [userId];
}
