import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cat_app_core/cat_app_core.dart';

import './localization.dart';
import '../blocs/cats_list/cats_list.dart';
import '../blocs/tab/tab.dart';
import 'blocs/navigation/nav_cubit.dart';
import './blocs/simple_bloc_observer.dart';

import './helpers/navigation.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return AllCatsBloc();
      },
      child: CatsApp(),
    ),
  );
}

class CatsApp extends StatelessWidget {
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
