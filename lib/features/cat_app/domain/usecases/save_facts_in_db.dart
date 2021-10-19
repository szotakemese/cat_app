import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveFactsInDb implements UseCase<void, SaveFactsInDbParams> {
  final CatAppRepository catAppRepository;

  SaveFactsInDb(this.catAppRepository);

  @override
  Future<Either<Failure, void>> call(SaveFactsInDbParams params) async {
    return await catAppRepository.saveFactsInDB(params.facts);
  }
}

class SaveFactsInDbParams extends Equatable {
    final List<CatFact> facts;

  SaveFactsInDbParams({
    required this.facts
  });

  @override
  List<Object> get props => [facts];
}
