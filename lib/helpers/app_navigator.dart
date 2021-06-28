import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/cats_screen.dart';
import '../screens/favourites_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/cat_detail_screen.dart';
import '../bloc/navigation/nav_cubit.dart';
import '../models/cat.dart';

class AppNavigator extends StatefulWidget {
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  List _allPages = [
    MaterialPage(child: CatsScreen()),
    MaterialPage(child: FavouritesScreen()),
    MaterialPage(child: ProfileScreen()),
  ];

  List<Page<dynamic>> _appPages = [];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavCubit, Cat?>(
        builder: (context, cat) {
          _appPages = [_allPages[_selectedPageIndex]];
          if (cat != null)
            _appPages.add(MaterialPage(child: CatDetailScreen(cat: cat)));
          return Navigator(
            pages: _appPages,
            onPopPage: (route, result) {
              BlocProvider.of<NavCubit>(context).popToCats();
              return route.didPop(result);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'List of Cats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile Page',
          ),
        ],
      ),
    );
  }
}
