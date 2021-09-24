import 'package:cat_app/helpers/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app_core/cat_app_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/auth.dart';
import 'package:cat_app/cubits/cubits.dart';

import 'widgets/navigator.dart';

import 'package:cat_app/helpers/database.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final DB dataBase = DB();
  await dataBase.openDB();

  final DataService dataService = DataService(dataBase: dataBase);
  
  runApp(Auth(
    authenticationRepository: authenticationRepository,
    dataBase: dataBase,
    dataService: dataService,
  ));
}

class CatsApp extends StatelessWidget {
  const CatsApp({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CatsApp());
  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthBloc bloc) => bloc.state.user);

    return MaterialApp(
      title: "Cat App",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.teal.shade900,
      ),
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
      ],
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => NavCubit(),
            ),
            BlocProvider<TabCubit>(
              create: (_) => TabCubit(),
            ),
            BlocProvider(
              create: (_) => CatsCubit(context.read<DataService>())..loadAllCats(user),
            ),
          ],
          child: child!,
        );
      },
      routes: {
        ArchSampleRoutes.home: (context) {
          return AppNavigator();
        },
      },
    );
  }
}
