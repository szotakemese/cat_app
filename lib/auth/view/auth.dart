import 'package:authentication_repository/authentication_repository.dart';
import 'package:cat_app/helpers/helpers.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/auth/auth.dart';

class Auth extends StatelessWidget {
  const Auth(
      {Key? key,
      required AuthenticationRepository authenticationRepository,
      required this.dataBase,
      required this.dataService})
      : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final DB dataBase;
  final DataService dataService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => dataBase,
        ),
        RepositoryProvider(
          create: (_) => dataService,
        ),
      ],
      child: RepositoryProvider.value(
        value: _authenticationRepository,
        // child: BlocProvider(
        //   create: (_) => AuthBloc(
        //     authenticationRepository: _authenticationRepository,
        //   ),
        //   child: const AuthView(),
        // ),
        child: BlocProvider(
          create: (_) => AuthCubit(
            authenticationRepository: _authenticationRepository,
          ),
          child: const AuthView(),
        ),
      ),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthCubit cubit) => cubit.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
