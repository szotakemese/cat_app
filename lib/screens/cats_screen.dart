import 'package:cat_app/bloc/cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/cats_cubit.dart';
import '../bloc/cats_state.dart';
// import '../models/cat.dart';
import '../widgets/cats_list.dart';

class CatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
      ),
      // body: BlocBuilder<CatsCubit, List<Cat>>(
      //   builder: (context, cats) {
      //     if (cats.isEmpty) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: cats.length,
      //       itemBuilder: (context, index) {
      //         return Card(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 15.0),
      //             child: ListTile(
      //               leading: Container(
      //                 width: 60,
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                     fit: BoxFit.cover,
      //                     image: NetworkImage(cats[index].url),
      //                   ),
      //                 ),
      //               ),
      //               title: Text(cats[index].id),
      //               trailing: IconButton(
      //                 icon: Icon(Icons.favorite_border),
      //                 onPressed: () {},
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //  },
      body: BlocBuilder<CatsBloc, CatsState>(builder: (context, state) {
        if (state is LoadingCatsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedCatsState) {
          return CatsList(state);
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
