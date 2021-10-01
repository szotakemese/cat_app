import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/auth/auth.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('homePage_logout_iconButton'),
      label: const Text(
        'LOGOUT',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        primary: Theme.of(context).colorScheme.secondary,
      ),
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
      onPressed: () =>
         context.read<AuthCubit>().logOutRequested(user),
    );
  }
}
