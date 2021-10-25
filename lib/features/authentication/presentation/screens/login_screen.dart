// import 'package:cat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:cat_app/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:cat_app/features/authentication/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider<LoginCubit>(
          // create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          create: (_) => sl<LoginCubit>(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
