import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/blocs/cats_list/cats_list.dart';
import 'package:cat_app/widgets/widgets.dart';

import 'package:cat_app/auth/auth.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          IconButton(
            onPressed: () async =>
                BlocProvider.of<AllCatsListBloc>(context).add(LoadAllCatsEvent(user.id)),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocBuilder<AllCatsListBloc, CatsState>(builder: (context, state) {
        if (state.status == CatsStatus.initial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CatsStatus.succes) {
          return FavouritesList(state);
          // return CatsList(state);
        } else if (state.status == CatsStatus.failure) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: (state.favourites.isEmpty && state.error.osError.errorCode == 7)
                  ? Text('No internet connection')
                  : Text(
                      'Error occured: ${state.error}',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          );
        }  else {
          return Container();
        }
      }),
    );
  }
}
