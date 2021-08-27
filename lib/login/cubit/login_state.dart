part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final dynamic error;

  @override
  List<Object> get props => [email, password, status, error];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    dynamic error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error,
    );
  }
}