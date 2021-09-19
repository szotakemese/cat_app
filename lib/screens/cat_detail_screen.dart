import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cats_list/all_cats_list_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

import 'package:cat_app/auth/auth.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;
  final int index;
  const CatDetailScreen({Key? key, required this.cat, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
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
                // child: Image.network(
                //   cat.url,
                //   fit: BoxFit.fitWidth,
                // ),
                child: CachedNetworkImage(
                  imageUrl: cat.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            Container(
              child: BlocBuilder<AllCatsListBloc, CatsState>(
                  builder: (context, state) {
                if (state.status == CatsStatus.loading ||
                    state.status == CatsStatus.initial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CatsStatus.succes) {
                  return CatFactWidget(state, index);
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
            IconButton(
              icon: cat.isFav
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              color: cat.isFav ? Colors.redAccent : Colors.grey,
              onPressed: () {
                if (!cat.isFav) {
                  print('==============ADD TO FAVOURITES===============');
                  // _dataService.setFav(
                  //   cat.id,
                  //   user.id,
                  // );
                  BlocProvider.of<AllCatsListBloc>(context).add(
                    CatAddedToFavs(cat: cat, userId: user.id),
                  );
                } else {
                  print('==============DELETE FROM FAVOURITES===============');
                  // print('ID: ${cat.id}');
                  // _dataService.deleteFav(
                  //   cat.id,
                  // );
                  BlocProvider.of<AllCatsListBloc>(context).add(
                    CatDeletedFromFavs(catId: cat.id),
                  );
                }

                print('STATUS FOR ${cat.id} was ${cat.isFav}');
                // BlocProvider.of<AllCatsListBloc>(context).add(
                //   CatUpdated(
                //     Cat(id: cat.id, url: cat.url, isFav: !cat.isFav),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
