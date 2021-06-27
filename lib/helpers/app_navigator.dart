import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/cats_screen.dart';
import '../screens/cat_detail_screen.dart';
import '../bloc/nav_cubit.dart';
import '../models/cat.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, Cat?>(
      builder: (context, cat) {
        return Navigator(
          pages: [
            MaterialPage(child: CatsScreen()),
            if( cat != null) MaterialPage(child: CatDetailScreen(cat: cat))
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToCats();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
