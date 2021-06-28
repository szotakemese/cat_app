import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cats_list/all_cats_bloc.dart';
import 'bloc/cats_list/fav_cats_bloc.dart';
import 'bloc/cats_list/cats_event.dart';
import 'bloc/navigation/nav_cubit.dart';

import './helpers/app_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.teal.shade900,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavCubit(),
          ),
          BlocProvider(
            create: (_) => AllCatsBloc()..add(LoadCatsEvent()),
          ),
          BlocProvider(
            create: (_) => FavCatsBloc()..add(LoadCatsEvent()),
          )
        ],
        child: AppNavigator(),
      ),
    );
  }
}
