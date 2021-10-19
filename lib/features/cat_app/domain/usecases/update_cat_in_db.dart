import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/cat.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateCatInDB implements UseCase<void, UpdateCatInDBParams> {
  final CatAppRepository catAppRepository;

  UpdateCatInDB(this.catAppRepository);

  @override
  Future<Either<Failure, void>> call(UpdateCatInDBParams params) async {
    return await catAppRepository.updateCatInDB(params.cat);
  }
}

class UpdateCatInDBParams extends Equatable {
  final Cat cat;

  UpdateCatInDBParams({
    required this.cat,
  });

  @override
  List<Object> get props => [cat];
}
