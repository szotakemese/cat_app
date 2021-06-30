import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../localization.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/tab_selector.dart';
import '../screens/screens.dart';

// ignore: must_be_immutable
class AppNavigator extends StatelessWidget {
  List<Page<dynamic>> _appPages = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(FlutterBlocLocalizations.of(context)!.appTitle),
          // ),
          body: activeTab == AppTab.all
              ? BlocBuilder<NavCubit, Cat?>(builder: (context, cat) {
                  _appPages = [MaterialPage(child: CatsScreen())];
                  if (cat != null)
                    _appPages
                        .add(MaterialPage(child: CatDetailScreen(cat: cat)));
                  return Navigator(
                    pages: _appPages,
                    onPopPage: (route, result) {
                      BlocProvider.of<NavCubit>(context).popToCats();
                      return route.didPop(result);
                    },
                  );
                })
              : (activeTab == AppTab.favourites)
                  ? FavouritesScreen()
                  : ProfileScreen(),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
