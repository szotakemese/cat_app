import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/auth/auth.dart';
import 'package:cat_app/data_service.dart';
import 'package:cat_app/blocs/blocs.dart';
import 'package:cat_app/models/models.dart';

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
    final cat = state.cats.firstWhere((cat) => cat.id == state.cats[index].id,
        orElse: () => null);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
          onTap: () {
            BlocProvider.of<NavCubit>(context)
                .showCatDetails(state.cats[index]);
            BlocProvider.of<CatFactsBloc>(context).add(LoadCatFactsEvent());
            print('Action: Open Details Screen');
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
            icon:
                cat.isFav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            color: cat.isFav ? Colors.redAccent : Colors.grey,
            onPressed: () {
              if (!cat.isFav) {
                print('==============ADD TO FAVOURITES===============');
                _dataService.setFav(
                  state.cats[index].id,
                  user.id,
                );
              } else {
                print('==============DELETE FROM FAVOURITES===============');
                print('ID: ${cat.id}');
                _dataService.deleteFav(
                  cat.id,
                );
              }

              print(
                  'STATUS FOR ${state.cats[index].id} was ${state.cats[index].isFav}');
              BlocProvider.of<AllCatsListBloc>(context).add(
                CatUpdated(
                  Cat(id: cat.id, url: cat.url, isFav: !cat.isFav),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
