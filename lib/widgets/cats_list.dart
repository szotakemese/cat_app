import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/navigation/nav_cubit.dart';

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
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListTile(
                    onTap: () => BlocProvider.of<NavCubit>(context)
                        .showCatDetails(state.cats[index]),
                    leading: Container(
                      width: 60,
                      child: Hero(
                        tag: state.cats[index].id,
                        child: Image.network(
                          state.cats[index].url,
                          fit: BoxFit.cover,
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
