import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:cat_app/features/cat_app/presentation/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthCubit cubit) => cubit.state.user);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff006666),
              Color(0xffddff99),
            ],
          ),
        ),
        child: Stack(children: [
          ProfileCard(user: user),
          Align(
              alignment: Alignment(0, -0.3), child: Avatar(photo: user.photo)),
        ]),
      ),
    );
  }
}
