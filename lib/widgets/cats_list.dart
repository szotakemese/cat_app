import 'package:flutter/material.dart';
class CatsList extends StatelessWidget {
  final state;
  const CatsList(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.cats.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListTile(
              leading: Container(
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(state.cats[index].url),
                  ),
                ),
              ),
              title: Text(state.cats[index].id),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
