// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../login/login.dart' as _i3;
import '../models/models.dart' as _i5;
import '../screens/screens.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginScreen());
    },
    HomeRoute.name: (routeData) {
      return _i1.MaterialPageX<String>(
          routeData: routeData, child: const _i4.HomeScreen());
    },
    CatsTab.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    FavouritesTab.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    ProfileTab.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ProfileScreen());
    },
    CatsRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.CatsScreen());
    },
    CatDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CatDetailRouteArgs>();
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.CatDetailScreen(
              key: args.key, cat: args.cat, index: args.index));
    },
    FavouritesRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.FavouritesScreen());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i1.RouteConfig(CatsTab.name, path: 'cats', children: [
            _i1.RouteConfig(CatsRoute.name, path: ''),
            _i1.RouteConfig(CatDetailRoute.name, path: ':id')
          ]),
          _i1.RouteConfig(FavouritesTab.name, path: 'favourites', children: [
            _i1.RouteConfig(FavouritesRoute.name, path: ''),
            _i1.RouteConfig(CatDetailRoute.name, path: ':id')
          ]),
          _i1.RouteConfig(ProfileTab.name, path: 'profile'),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '/home', fullMatch: true)
        ])
      ];
}

class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

class CatsTab extends _i1.PageRouteInfo<void> {
  const CatsTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'cats', initialChildren: children);

  static const String name = 'CatsTab';
}

class FavouritesTab extends _i1.PageRouteInfo<void> {
  const FavouritesTab({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'favourites', initialChildren: children);

  static const String name = 'FavouritesTab';
}

class ProfileTab extends _i1.PageRouteInfo<void> {
  const ProfileTab() : super(name, path: 'profile');

  static const String name = 'ProfileTab';
}

class CatsRoute extends _i1.PageRouteInfo<void> {
  const CatsRoute() : super(name, path: '');

  static const String name = 'CatsRoute';
}

class CatDetailRoute extends _i1.PageRouteInfo<CatDetailRouteArgs> {
  CatDetailRoute({_i2.Key? key, required _i5.Cat cat, required int index})
      : super(name,
            path: ':id',
            args: CatDetailRouteArgs(key: key, cat: cat, index: index),
            rawPathParams: {});

  static const String name = 'CatDetailRoute';
}

class CatDetailRouteArgs {
  const CatDetailRouteArgs({this.key, required this.cat, required this.index});

  final _i2.Key? key;

  final _i5.Cat cat;

  final int index;
}

class FavouritesRoute extends _i1.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '');

  static const String name = 'FavouritesRoute';
}
