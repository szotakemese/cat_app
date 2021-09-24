import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubits.dart';
import 'tab_selector.dart';
import '../screens/screens.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          body: activeTab == AppTab.all
              ? CatsScreen()
              : ((activeTab == AppTab.favourites)
                  ? FavouritesScreen()
                  : ProfileScreen()),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabCubit>(context).updateTab(tab),
          ),
        );
      },
    );
  }
}
