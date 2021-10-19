import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
import 'package:dartz/dartz.dart';

class GetCatFacts implements UseCase<List<CatFact>, NoParams> {
  final CatAppRepository catAppRepository;

  GetCatFacts(this.catAppRepository);
  
  @override
  Future<Either<Failure, List<CatFact>>> call(NoParams params) async {
    return await catAppRepository.getCatFacts();
  }
}

