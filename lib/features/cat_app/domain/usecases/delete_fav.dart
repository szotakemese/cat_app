import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteFav implements UseCase<void, DeleteFavParams> {
  final CatAppRepository catAppRepository;

  DeleteFav(this.catAppRepository);

  @override
  Future<Either<Failure, void>> call(DeleteFavParams params) async {
    return await catAppRepository.deleteFav(params.favId);
  }
}


class DeleteFavParams extends Equatable {
  final String favId;

  DeleteFavParams({
    required this.favId,
  });

  @override
  List<Object> get props => [favId];
}