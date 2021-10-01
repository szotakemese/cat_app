// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../features/cat_app/domain/entities/entities.dart' as _i5;
import '../login/login.dart' as _i1;
import '../screens/screens.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<String>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    CatsTab.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    FavouritesTab.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ProfileTab.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ProfileScreen());
    },
    CatsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.CatsScreen());
    },
    CatDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CatDetailRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.CatDetailScreen(
              key: args.key, cat: args.cat, index: args.index));
    },
    FavouritesRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.FavouritesScreen());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i3.RouteConfig(LoginRoute.name, path: '/login'),
        _i3.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i3.RouteConfig(CatsTab.name, path: 'cats', children: [
            _i3.RouteConfig(CatsRoute.name, path: ''),
            _i3.RouteConfig(CatDetailRoute.name, path: ':id')
          ]),
          _i3.RouteConfig(FavouritesTab.name, path: 'favourites', children: [
            _i3.RouteConfig(FavouritesRoute.name, path: ''),
            _i3.RouteConfig(CatDetailRoute.name, path: ':id')
          ]),
          _i3.RouteConfig(ProfileTab.name, path: 'profile'),
          _i3.RouteConfig('*#redirect',
              path: '*', redirectTo: '/home', fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.LoginScreen]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.EmptyRouterPage]
class CatsTab extends _i3.PageRouteInfo<void> {
  const CatsTab({List<_i3.PageRouteInfo>? children})
      : super(name, path: 'cats', initialChildren: children);

  static const String name = 'CatsTab';
}

/// generated route for [_i3.EmptyRouterPage]
class FavouritesTab extends _i3.PageRouteInfo<void> {
  const FavouritesTab({List<_i3.PageRouteInfo>? children})
      : super(name, path: 'favourites', initialChildren: children);

  static const String name = 'FavouritesTab';
}

/// generated route for [_i2.ProfileScreen]
class ProfileTab extends _i3.PageRouteInfo<void> {
  const ProfileTab() : super(name, path: 'profile');

  static const String name = 'ProfileTab';
}

/// generated route for [_i2.CatsScreen]
class CatsRoute extends _i3.PageRouteInfo<void> {
  const CatsRoute() : super(name, path: '');

  static const String name = 'CatsRoute';
}

/// generated route for [_i2.CatDetailScreen]
class CatDetailRoute extends _i3.PageRouteInfo<CatDetailRouteArgs> {
  CatDetailRoute({_i4.Key? key, required _i5.Cat cat, required int index})
      : super(name,
            path: ':id',
            args: CatDetailRouteArgs(key: key, cat: cat, index: index),
            rawPathParams: {});

  static const String name = 'CatDetailRoute';
}

class CatDetailRouteArgs {
  const CatDetailRouteArgs({this.key, required this.cat, required this.index});

  final _i4.Key? key;

  final _i5.Cat cat;

  final int index;
}

/// generated route for [_i2.FavouritesScreen]
class FavouritesRoute extends _i3.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '');

  static const String name = 'FavouritesRoute';
}
