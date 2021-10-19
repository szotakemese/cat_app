import 'package:cat_app/features/cat_app/data/datasources/cat_app_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:auto_route/auto_route.dart';

// import 'package:cat_app/helpers/bloc_observer.dart';
import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/navigation/navigation.dart';

import 'injection_container.dart' as ic;


void main() async {
  // Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  await authenticationRepository.user.first;

  // final DB dataBase = DB();
  // await dataBase.openDB();

  // final DataService dataService = DataService(dataBase: dataBase);
  
  // runApp(Auth(
  //   authenticationRepository: authenticationRepository,
  //   dataBase: localDataSource,
  //   dataService: dataService,
  // ));
  ic.init();

  await ic.sl<CatAppLocalDataSource>().openDB();

  runApp(Auth(authenticationRepository: authenticationRepository,));
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
          primary: Colors.orange.shade400,
          secondary: Colors.teal.shade800,
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
