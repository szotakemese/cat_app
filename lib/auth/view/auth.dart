import 'package:authentication_repository/authentication_repository.dart';
import 'package:cat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/auth/auth.dart';

class Auth extends StatelessWidget {
  const Auth({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    // required CatAppRepository catAppRepository
  })  : _authenticationRepository = authenticationRepository,
        // _catAppRepository = catAppRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  // final CatAppRepository _catAppRepository;

  @override
  Widget build(BuildContext context) {
    // return MultiRepositoryProvider(
    //   providers: [
        // RepositoryProvider(
        //   create: (_) => _catAppRepository,
        // )
      // ],
      // child: 
      return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthCubit(
            authenticationRepository: _authenticationRepository,
          ),
          child: const CatsApp(),
        ),
      // ),
    );
  }
}
