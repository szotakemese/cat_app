import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';

class GetCurrentUser implements GetUseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  GetCurrentUser(this.authenticationRepository);

  @override
  User call(NoParams params)  =>  authenticationRepository.currentUser;
}