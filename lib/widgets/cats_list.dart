import 'package:flutter/material.dart';
import 'cats_list_item.dart';

class CatsList extends StatelessWidget {
  final state;
  const CatsList(this.state);
  @override
  Widget build(BuildContext context) {
    return state.cats.length == 0
        ? Center(
            child: Text('Favourite Cats List is empty'),
          )
        : ListView.builder(
            itemCount: state.cats.length,
            itemBuilder: (context, index) {
              return CatsListItem(state: state, index: index,);
            },
          );
  }
}
