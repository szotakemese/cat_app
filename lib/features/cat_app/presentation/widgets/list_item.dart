import 'package:authentication_repository/authentication_repository.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/navigation/navigation.dart';
import './widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.cat,
    required this.onCatsScreen,
  }) : super(key: key);

  final Cat cat;
  final bool onCatsScreen;

  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthCubit bloc) => bloc.state.user);
    final String additionalTag = onCatsScreen ? 'cat' : 'fav';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
            onTap: () =>
                CatDetailRoute(catId: cat.id, onCatsScreen: onCatsScreen)
                    .show(context),
            leading: Container(
              width: 60,
              child: Hero(
                tag: cat.id + additionalTag,
                child: CachedNetworkImage(
                  imageUrl: cat.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            title: Text(cat.id),
            trailing: LikeIcon(
              cat: cat,
              user: user,
              state: context.read<CatAppCubit>().state,
            )),
      ),
    );
  }
}
