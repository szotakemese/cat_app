import 'package:cat_app/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cat_app_core/cat_app_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/auth.dart';
import './blocs/blocs.dart';

import './helpers/navigation.dart';

import 'package:cat_app/helpers/database.dart';

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

  final dataBase = DB();
  await dataBase.openDB();
  // await DB().openDB();

  final dataService = DataService(dataBase: dataBase);
  
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
    final user = context.select((AuthBloc bloc) => bloc.state.user);

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
            BlocProvider<TabBloc>(
              create: (_) => TabBloc(),
            ),
            BlocProvider(
              create: (_) => AllCatsListBloc(context.read<DataService>())..add(LoadAllCatsEvent(user.id)),
            ),
            // BlocProvider(
            //   create: (_) => FavCatsListBloc()..add(LoadFavCatsEvent()),
            // ),
            BlocProvider(
              create: (_) => CatFactsBloc(context.read<DataService>())..add(LoadCatFactsEvent()),
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
