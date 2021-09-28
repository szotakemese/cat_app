import 'package:auto_route/auto_route.dart';
import 'package:cat_app/navigation/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(context) {
    return Column(
      children: [
        Expanded(
          child: AutoTabsScaffold(
            homeIndex: 0,
            routes: [
              CatsTab(),
              FavouritesTab(),
              ProfileTab(),
            ],
            bottomNavigationBuilder: buildBottomNav,
          ),
        ),
      ],
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
