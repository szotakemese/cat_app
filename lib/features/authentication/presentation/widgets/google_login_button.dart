import 'package:cat_app/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        key: const Key('loginForm_googleLogin_raisedButton'),
        label: const Text(
          'SIGN IN WITH GOOGLE',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(13.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: Theme.of(context).colorScheme.primary,
          fixedSize: Size(240, 50),
        ),
        icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
        onPressed: () {
          context.read<LoginCubit>().logInWithGoogle();
        });
  }
}
