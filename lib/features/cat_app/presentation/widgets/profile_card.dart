import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/cat_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({required this.user, Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 230,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff0f0f0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  Text(user.email ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 4.0),
                  Text(user.name ?? '',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 30,
                      )),
                  const SizedBox(height: 40.0),
                  LogoutButton(user: user),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
