import 'dart:async';
import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Stream<User> get user;
  User get currentUser;
  Future<Either<Failure, void>> logInWithGoogle();
  Future<Either<Failure, void>> logInWithFacebok();
  Future<Either<Failure, void>> logOut();
}
