import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/authentication/domain/usecases/get_current_user.dart';
import 'package:cat_app/features/authentication/domain/usecases/get_user.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_out.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_analysis/very_good_analysis.dart';
import '../../../domain/entities/auth_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.getUser,
    required this.getCurrentUser,
    required this.logOut,
  }) : super(
          getCurrentUser(NoParams()).isEmpty
              ? AuthState.authenticated(getCurrentUser(NoParams()))
              : const AuthState.unauthenticated(),
        ) {
    _userSubscription = getUser(NoParams()).listen(_onUserChanged);
  }

  late final StreamSubscription<User> _userSubscription;
  final GetUser getUser;
  final GetCurrentUser getCurrentUser;
  final LogOut logOut;

  void _onUserChanged(User user) => userChanged(user);

  void userChanged(User user) {
    emit(user.isNotEmpty
        ? AuthState.authenticated(user)
        : const AuthState.unauthenticated());
  }

  Future<void> logOutRequested(User user) async {
    unawaited(logOut(NoParams()));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
