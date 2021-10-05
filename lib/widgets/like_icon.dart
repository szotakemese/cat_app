import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/cubits/cubits.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';

class LikeIcon extends StatelessWidget {
  const LikeIcon({
    Key? key,
    required this.cat,
    required this.user,
    required this.state,
  }) : super(key: key);

  final Cat cat;
  final User user;
  final CatsState state;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: state.isFaved(cat)
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
      color: state.isFaved(cat) ? Colors.redAccent : Colors.grey,
      onPressed: () {
        if (!cat.isFav) {
          context.read<CatsCubit>().addCatToFavs(cat, user);
        } else {
          context.read<CatsCubit>().deleteFromFavs(cat);
        }
      },
    );
  }
}
