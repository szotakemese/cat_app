import 'package:cat_app/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/login/login.dart';
import 'package:cat_app/main.dart';

List<Page> onGenerateAppViewPages(AuthStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthStatus.waiting:
      return [SplashScreen.page()];
    case AuthStatus.authenticated:
      return [CatsApp.page()];
    case AuthStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}