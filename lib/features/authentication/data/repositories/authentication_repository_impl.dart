import 'dart:async';
import 'package:cat_app/core/error/exceptions.dart';
import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  User get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? User.empty;
  }

  Future<Either<Failure, void>> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final firebase_auth.OAuthCredential authCredential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final void signIn =
          await _firebaseAuth.signInWithCredential(authCredential);
      return Right(signIn);
    } on LogInWithGoogleException {
      return Left(LogInWithFacebookFailure());
    }
  }

  Future<Either<Failure, void>> logInWithFacebok() async {
    final FacebookLoginResult res = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    if (res.status == FacebookLoginStatus.success) {
      try {
        final FacebookAccessToken? accessToken = res.accessToken;
        final firebase_auth.AuthCredential authCredential =
            firebase_auth.FacebookAuthProvider.credential(accessToken!.token);
        final void signIn = await firebase_auth.FirebaseAuth.instance
            .signInWithCredential(authCredential);
        return Right(signIn);
      } on LogInWithFacebookException {
        return Left(LogInWithFacebookFailure());
      }
    } else
      return Left(LogInWithFacebookFailure());
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final void logOut = await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookLogin.logOut(),
      ]);
      return Right(logOut);
    } on LogOutException {
      return Left(LogOutFailure());
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
