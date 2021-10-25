import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogOut implements UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LogOut(this.authenticationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authenticationRepository.logOut();
  }
}