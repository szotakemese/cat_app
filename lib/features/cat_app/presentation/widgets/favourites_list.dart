import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';
import './widgets.dart';

class FavouritesList extends StatelessWidget {
  final CatAppState state;
  const FavouritesList(this.state);
  @override
  Widget build(BuildContext context) {
    return state.favourites.length == 0
        ? Center(
            child: Text('Favourites List is empty'),
          )
        : ListView.builder(
            itemCount: state.favourites.length,
            itemBuilder: (context, index) {
              return ListItem(
                key: Key(index.toString()),
                cat: state.favourites[index],
                onCatsScreen: false,
              );
            },
          );
  }
}
