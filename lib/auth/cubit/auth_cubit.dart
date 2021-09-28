import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'cubit.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => userChanged(user);

  void userChanged (User user) {
    emit(user.isNotEmpty
        ? AuthState.authenticated(user)
        : const AuthState.unauthenticated());
  }
  
  Future<void> logOutRequested(User user) async =>  unawaited(_authenticationRepository.logOut());

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
