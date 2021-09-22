part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.error,
  });
  final FormzStatus status;
  final dynamic error;

  @override
  List<Object> get props => [status, error];

  LoginState copyWith({
    FormzStatus? status,
    dynamic error,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error,
    );
  }
}