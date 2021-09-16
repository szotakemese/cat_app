import 'package:flutter/material.dart';
import 'list_item.dart';

class FavouritesList extends StatelessWidget {
  final state;
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
                // state: state,
                // index: index,
                // listType: state.favourites,
                cat: state.favourites[index],
              );
            },
          );
  }
}
