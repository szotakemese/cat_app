import 'package:authentication_repository/authentication_repository.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_app/features/cat_app/presentation/widgets/favourites_list.dart';
import 'package:cat_app/auth/auth.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthCubit cubit) => cubit.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          IconButton(
            onPressed: () async =>
                BlocProvider.of<CatAppCubit>(context).loadAllCats(user),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocBuilder<CatAppCubit, CatAppState>(builder: (context, state) {
        if (state.status == CatAppStatus.initial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CatAppStatus.succes) {
          return FavouritesList(state);
        } else if (state.status == CatAppStatus.failure) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: (state.favourites.isEmpty &&
                      state.error.osError.errorCode == 7)
                  ? Text('No internet connection')
                  : Text(
                      'Error occured: ${state.error}',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
