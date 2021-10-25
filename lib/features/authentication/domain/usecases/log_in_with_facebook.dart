import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogInWithFacebook implements UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LogInWithFacebook(this.authenticationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authenticationRepository.logInWithFacebok();
  }
}