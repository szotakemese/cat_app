import 'package:cat_app/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/auth/auth.dart';
// import 'package:cat_app/data_service.dart';
import 'package:cat_app/blocs/blocs.dart';
import 'package:cat_app/models/models.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.state,
    required this.index,
    required this.listType,
  }) : super(key: key);

  final state;
  final index;
  final listType;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    // final _dataService = DataService();
    // final cat = state.cats.firstWhere((cat) => cat.id == state.cats[index].id,
    // orElse: () => null);
    final cat = listType.firstWhere((cat) => cat.id == listType[index].id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CatDetailScreen(
                  cat: cat,
                  index: index,
                ),
              ),
            );
            // BlocProvider.of<NavCubit>(context)
            //     .showCatDetails(state.cats[index]);
            BlocProvider.of<CatFactsBloc>(context).add(LoadCatFactsEvent());
            print('Action: Open Details Screen');
          },
          leading: Container(
            width: 60,
            child: Hero(
              tag: cat.id,
              child: Image.network(
                cat.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(cat.id),
          trailing: IconButton(
            icon:
                cat.isFav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            color: cat.isFav ? Colors.redAccent : Colors.grey,
            onPressed: () {
              if (!cat.isFav) {
                print('==============ADD TO FAVOURITES===============');
                // _dataService.setFav(
                //   cat.id,
                //   user.id,
                // );
                BlocProvider.of<AllCatsListBloc>(context).add(
                  CatAddedToFavs(catId: cat.id, userId: user.id),
                );
              } else {
                print('==============DELETE FROM FAVOURITES===============');
                // print('ID: ${cat.id}');
                // _dataService.deleteFav(
                //   cat.id,
                // );
                BlocProvider.of<AllCatsListBloc>(context).add(
                  CatDeletedFromFavs(catId: cat.id),
                );
              }

              print('STATUS FOR ${cat.id} was ${cat.isFav}');
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
