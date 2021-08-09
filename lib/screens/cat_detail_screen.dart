import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cat_facts/cat_facts.dart';

import 'package:cat_app/blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailScreen({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: Colors.redAccent,
            onPressed: () {

            print('STATUS FOR ${cat.id} was ${cat.isFav}');
              BlocProvider.of<AllCatsListBloc>(context).add(
                CatUpdated(
                  Cat(id: cat.id, url: cat.url, isFav: !cat.isFav),
                ),
              );
            print('STATUS FOR ${cat.id} after tap ${cat.isFav}');
            },
          ),
          ],
        ),
      ),
    );
  }
}
