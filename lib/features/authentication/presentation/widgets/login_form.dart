import 'package:cat_app/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import 'facebook_login_button.dart';
import 'google_login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text((state.error.code.toString() == 'network_error')
                      ? "No internet connection"
                      : state.error.message.toString())),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Continue with social media",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 50,
            ),
            GoogleLoginButton(),
            const SizedBox(height: 20.0),
            FacebookLoginButton(),
          ],
        ),
      ),
    );
  }
}
