import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveCatsInDb implements UseCase<void, SaveCatsInDbParams> {
  final CatAppRepository catAppRepository;

  SaveCatsInDb(this.catAppRepository);

  @override
  Future<Either<Failure, void>> call(SaveCatsInDbParams params) async {
    return await catAppRepository.saveCatsInDB(params.cats);
  }
}

class SaveCatsInDbParams extends Equatable {
    final List<Cat> cats;

  SaveCatsInDbParams({
    required this.cats
  });

  @override
  List<Object> get props => [cats];
}
