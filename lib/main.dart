import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/cats_bloc.dart';
import './bloc/cats_event.dart';
import './bloc/nav_cubit.dart';

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
        accentColor: Colors.teal,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavCubit(),
          ),
          BlocProvider(
            create: (_) => CatsBloc()..add(LoadCatsEvent()),
          )
        ],
        child: AppNavigator(),
      ),
    );
  }
}
