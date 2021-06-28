import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cats_list/all_cats_bloc.dart';
import '../bloc/cats_list/cats_event.dart';

import '../bloc/cats_list/cats_state.dart';
import '../widgets/cats_list.dart';

class CatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
      ),
      body: BlocBuilder<AllCatsBloc, CatsState>(builder: (context, state) {
        if (state is LoadingCatsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedCatsState) {
          return RefreshIndicator(
            child: CatsList(state),
            onRefresh: () async =>
                BlocProvider.of<AllCatsBloc>(context).add(PullToRefreshEvent()),
          );
        } else if (state is FailedLoadCatsState) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Error occured ${state.error}',
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
