import 'package:cat_app/blocs/cats_list/cats_state.dart';
import 'package:flutter/material.dart';
import 'list_item.dart';

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
                index: index,
                cat: state.favourites[index],
              );
            },
          );
  }
}
