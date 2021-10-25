import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:cat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';

import '../../../injection_container.dart';

class Auth extends StatelessWidget {
  const Auth({
    Key? key,
    // required AuthenticationRepository authenticationRepository,
  })  : 
  // _authenticationRepository = authenticationRepository,
        super(key: key);

  // final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
      return RepositoryProvider.value(
        value: sl<AuthenticationRepository>(),
        child: BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(
            // authenticationRepository: _authenticationRepository,
          ),
          child: const CatsApp(),
        ),
    );
  }
}
