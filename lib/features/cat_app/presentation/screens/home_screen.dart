import 'package:auto_route/auto_route.dart';
import 'package:cat_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:cat_app/features/cat_app/presentation/navigation/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return BlocProvider<CatAppCubit>(
      create: (context) =>
          sl<CatAppCubit>()..loadAllCats(context.read<AuthCubit>().state.user),
      child: Scaffold(
        body: AutoTabsScaffold(
          homeIndex: 0,
          routes: [
            CatsTab(),
            FavouritesTab(),
            ProfileTab(),
          ],
          bottomNavigationBuilder: buildBottomNav,
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNav(
      BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Cats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Profile',
        ),
      ],
    );
  }
}
