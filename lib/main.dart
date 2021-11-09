import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:auto_route/auto_route.dart';

// import 'package:cat_app/helpers/bloc_observer.dart';
import 'package:cat_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:cat_app/features/cat_app/presentation/navigation/navigation.dart';

import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/entities/auth_status.dart';
import 'features/authentication/view/auth.dart';
import 'injection_container.dart' as ic;

void main() async {
  // Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await ic.init();
  await ic.sl<AuthenticationRepository>().user.first;

  runApp(Auth());
}

final _appRouter = AppRouter();

class CatsApp extends StatelessWidget {
  const CatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthState authState =
        context.select((AuthCubit cubit) => cubit.state);
    final ThemeData theme = ThemeData();

    return MaterialApp.router(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Color(0xff006666),
          secondary: Color(0xffddff99),
        ),
      ),
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: (_) => [
          authState.status == AuthStatus.authenticated
              ? HomeRoute()
              : LoginRoute()
        ],
      ),
      routeInformationProvider: AutoRouteInformationProvider(),
      routeInformationParser:
          _appRouter.defaultRouteParser(includePrefixMatches: true),
      title: "Cat App",
    );
  }
}
