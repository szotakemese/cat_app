import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cat_app_core/cat_app_core.dart';
import '../models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      unselectedItemColor: Theme.of(context).accentColor,
      selectedItemColor: Theme.of(context).primaryColor,
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.all
                ? Icons.view_list
                : (tab == AppTab.favourites)
                    ? Icons.star
                    : Icons.account_box,
            key: tab == AppTab.all
                ? ArchSampleKeys.catsListTab
                : (tab == AppTab.favourites) ? ArchSampleKeys.favouritesTab : ArchSampleKeys.profileTab,
          ),
          label: tab == AppTab.all
              ? 'List of Cats'
              : (tab == AppTab.favourites)
                  ? 'Favourites'
                  : 'Profile Page',
        );
      }).toList(),
    );
  }
}
