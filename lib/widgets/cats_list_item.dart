import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/data_service.dart';

import '../blocs/blocs.dart';

class CatsListItem extends StatelessWidget {
  const CatsListItem({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final state;
  final index;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final _dataService = DataService();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
          onTap: () {
            BlocProvider.of<NavCubit>(context)
                .showCatDetails(state.cats[index]);
            BlocProvider.of<CatFactsBloc>(context).add(LoadCatFactsEvent());
          },
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
            onPressed: () => _dataService.setFav(
              state.cats[index].id,
              user.id,
            ),
          ),
        ),
      ),
    );
  }
}
