import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cats_list/cats_list.dart';
import '../widgets/cats_list.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          IconButton(
            onPressed: () async =>
                BlocProvider.of<FavCatsBloc>(context).add(PullToRefreshEvent()),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocBuilder<FavCatsBloc, CatsState>(builder: (context, state) {
        if (state is LoadingCatsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedCatsState) {
          return CatsList(state);
        } else if (state is FailedLoadCatsState) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Error occured ${state.error}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
