import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/cubits/cubits.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/widgets/widgets.dart';
import 'package:cat_app/auth/auth.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;
  final int index;

  const CatDetailScreen({
    Key? key,
    required this.cat,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthCubit cubit) => cubit.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ' + cat.id),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              child: Hero(
                tag: cat.id,
                child: CachedNetworkImage(
                  imageUrl: cat.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            Container(
              child:
                  BlocBuilder<CatsCubit, CatsState>(builder: (context, state) {
                if (state.status == CatsStatus.loading ||
                    state.status == CatsStatus.initial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CatsStatus.succes) {
                  return Column(
                    children: [
                      CatFactWidget(state, index),
                      IconButton(
                        icon: state.isFaved(cat)
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        color:
                            state.isFaved(cat) ? Colors.redAccent : Colors.grey,
                        onPressed: () {
                          if (!cat.isFav) {
                            context.read<CatsCubit>().addCatToFavs(cat, user);
                          } else {
                            context.read<CatsCubit>().deleteFromFavs(cat);
                          }
                          print('STATUS FOR ${cat.id} was ${cat.isFav}');
                        },
                      ),
                    ],
                  );
                } else if (state.status == CatsStatus.failure) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'Error occured: ${state.error}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
