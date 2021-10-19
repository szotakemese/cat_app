import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetNewCats implements UseCase<List<Cat>, GetNewCatsParams> {
  final CatAppRepository catAppRepository;

  GetNewCats(this.catAppRepository);

  @override
  Future<Either<Failure, List<Cat>>> call(GetNewCatsParams params) async {
    return await catAppRepository.getNewCats(params.page);
  }
}

class GetNewCatsParams extends Equatable {
  final int page;

  GetNewCatsParams({
    required this.page,
  });

  @override
  List<Object> get props => [page];
}
