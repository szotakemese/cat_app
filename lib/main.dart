import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/cats_cubit.dart';
import './screens/cats_screen.dart';
// import 'data_service.dart';

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
      ),
      home: BlocProvider<CatsCubit>(
        create: (_) => CatsCubit()..getCats(),
        child: CatsScreen(),
      ),
    );
  }
}
