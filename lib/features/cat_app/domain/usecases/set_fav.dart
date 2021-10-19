import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SetFav implements UseCase<void, SetFavParams> {
  final CatAppRepository catAppRepository;

  SetFav(this.catAppRepository);

  @override
  Future<Either<Failure, void>> call(SetFavParams params) async {
    return await catAppRepository.setFav(params.catId, params.userId);
  }
}

class SetFavParams extends Equatable {
  final String catId;
  final String userId;

  SetFavParams({
    required this.catId,
    required this.userId,
  });

  @override
  List<Object> get props => [catId, userId];
}