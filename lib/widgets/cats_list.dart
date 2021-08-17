import 'package:flutter/material.dart';
import 'list_item.dart';

class CatsList extends StatelessWidget {
  final state;
  const CatsList(this.state);
  @override
  Widget build(BuildContext context) {
    return state.cats.length == 0
        ? Center(
            child: Text('Cats List is empty'),
          )
        : ListView.builder(
            itemCount: state.cats.length,
            itemBuilder: (context, index) {
              return ListItem(key: Key(index.toString()), state: state, index: index, listType: state.cats,);
              // return ListItem(key: Key(index.toString()), state: state, index: index,);
            },
          );
  }
}
