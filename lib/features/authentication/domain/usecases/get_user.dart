import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';

class GetUser implements GetUseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  GetUser(this.authenticationRepository);

  @override
  Stream<User> call(NoParams params)  =>  authenticationRepository.user;
}