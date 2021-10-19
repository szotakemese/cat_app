import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
// import 'package:cat_app/helpers/helpers.dart';
import 'package:equatable/equatable.dart';
import 'cubit.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthenticationRepository authenticationRepository,
    // required this.dataBase,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  // final DB dataBase;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => userChanged(user);

  void userChanged(User user) {
    emit(user.isNotEmpty
        ? AuthState.authenticated(user)
        : const AuthState.unauthenticated());
  }

  Future<void> logOutRequested(User user) async {
    unawaited(_authenticationRepository.logOut());
    // if (state.status == AuthStatus.unauthenticated) dataBase.closeDB();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
