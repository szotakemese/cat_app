import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class LogInWithGoogleFailure extends Failure {}

class LogInWithFacebookFailure extends Failure {}

class LogOutFailure extends Failure {}
