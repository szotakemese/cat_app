import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  final dynamic message;
  const LogInWithGoogleFailure(this.message);
}

/// Thrown during the sign in with Facebook process if a failure occurs.
class LogInWithFacebookFailure implements Exception {
  final dynamic message;
  const LogInWithFacebookFailure(this.message);
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin fb = FacebookLogin();

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  User get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? User.empty;
  }

  Future<void> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final firebase_auth.OAuthCredential  authCredential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(authCredential);
    } catch (e) {
      print("err: $e");
      if(e is PlatformException){
        if(e.code == "network_error") throw LogInWithGoogleFailure("No internet connection");
        throw LogInWithGoogleFailure(e.code);
      }
      throw LogInWithGoogleFailure(e);
    }
  }

  Future<void> logInWithFacebok() async {
    final FacebookLoginResult res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        try {
          final FacebookAccessToken? accessToken = res.accessToken;
          final firebase_auth.AuthCredential authCredential =
              firebase_auth.FacebookAuthProvider.credential(accessToken!.token);
          await firebase_auth.FirebaseAuth.instance
              .signInWithCredential(authCredential);
        } catch (e) {
          if (e is firebase_auth.FirebaseAuthException) {
            throw LogInWithFacebookFailure(e.message);
          }
          throw LogInWithFacebookFailure(e);
        }
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}!');
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
  
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        fb.logOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
