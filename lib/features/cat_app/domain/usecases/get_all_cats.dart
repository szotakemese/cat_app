import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllCats implements UseCase<List<Cat>, int> {
  final CatAppRepository catAppRepository;

  GetAllCats(this.catAppRepository);

  @override
  Future<Either<Failure, List<Cat>>> call(int page) async {
    return await catAppRepository.getAllCats(page);
  }
}

class Params extends Equatable {
  final int page;

  Params({required this.page}) : super();

  @override
  List<Object> get props => [page];
}
