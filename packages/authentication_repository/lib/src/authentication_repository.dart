import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
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

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // Create an instance of FacebookLogin
  final fb = FacebookLogin();

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [logInWithGoogle] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final authCredential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(authCredential);
    } on Exception catch (e) {
      throw LogInWithGoogleFailure(e);
    }
  }

  ///=======================================================
  /// Starts the Sign In with Facebook.
  ///
  ///
  Future<void> logInWithFacebok() async {
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
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

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  ///========================================================

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
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
