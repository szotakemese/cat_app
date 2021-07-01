import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cat_app_core/cat_app_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/auth.dart';
import './localization.dart';
import './blocs/blocs.dart';

import './helpers/navigation.dart';

// void main() {
//   Bloc.observer = SimpleBlocObserver();
//   runApp(
//     BlocProvider(
//       create: (context) {
//         return AllCatsBloc();
//       },
//       child: CatsApp(),
//     ),
//   );
// }

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(Auth(authenticationRepository: authenticationRepository));
}

class CatsApp extends StatelessWidget {
  const CatsApp({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CatsApp());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.teal.shade900,
      ),
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => NavCubit(),
              ),
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider(
                create: (_) => AllCatsBloc()..add(LoadCatsEvent()),
              ),
              BlocProvider(
                create: (_) => FavCatsBloc()..add(LoadCatsEvent()),
              )
            ],
            child: AppNavigator(),
          );
        },
      },
    );
  }

}
