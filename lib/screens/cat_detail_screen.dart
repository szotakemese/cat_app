import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cat_facts/cat_facts.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/data_service.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailScreen({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final _dataService = DataService();
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ' + cat.id),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: cat.id,
                child: Image.network(
                  cat.url,
                  fit: BoxFit.fitWidth,
                )),
            Container(
              child: BlocBuilder<CatFactsBloc, CatFactsState>(
                  builder: (context, state) {
                if (state is LoadingCatFactsState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedCatFactsState) {
                  return CatFactWidget(state);
                } else if (state is FailedLoadCatFactsState) {
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
            icon:
                cat.isFav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            color: cat.isFav ? Colors.redAccent : Colors.grey,
            onPressed: () {
              if (!cat.isFav) {
                print('==============ADD TO FAVOURITES===============');
                _dataService.setFav(
                  cat.id,
                  user.id,
                );
              } else {
                print('==============DELETE FROM FAVOURITES===============');
                print('ID: ${cat.id}');
                _dataService.deleteFav(
                  cat.id,
                );
              }

              print(
                  'STATUS FOR ${cat.id} was ${cat.isFav}');
              BlocProvider.of<AllCatsListBloc>(context).add(
                CatUpdated(
                  Cat(id: cat.id, url: cat.url, isFav: !cat.isFav),
                ),
              );
            },
          ),
          ],
        ),
      ),
    );
  }
}
