import 'package:cat_app/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/widgets/widgets.dart';

class FavouritesList extends StatelessWidget {
  final CatsState state;
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
