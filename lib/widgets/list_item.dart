import 'package:authentication_repository/authentication_repository.dart';
import 'package:cat_app/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/blocs/blocs.dart';
import 'package:cat_app/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.index,
    required this.cat,
  }) : super(key: key);

  final int index;
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthBloc bloc) => bloc.state.user);

    return BlocBuilder<AllCatsListBloc, CatsState>(builder: (context, state) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CatDetailScreen(
                    cat: cat,
                    index: index,
                  ),
                ),
              );
              print('Action: Open Details Screen');
            },
            leading: Container(
              width: 60,
              child: Hero(
                tag: cat.id,
                child: CachedNetworkImage(
                  imageUrl: cat.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            title: Text(cat.id),
            trailing: IconButton(
              icon: cat.isFav
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              color: cat.isFav ? Colors.redAccent : Colors.grey,
              onPressed: () {
                if (!cat.isFav) {
                  BlocProvider.of<AllCatsListBloc>(context).add(
                    CatAddedToFavs(cat: cat, userId: user.id),
                  );
                } else {
                  BlocProvider.of<AllCatsListBloc>(context).add(
                    CatDeletedFromFavs(cat: cat),
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
