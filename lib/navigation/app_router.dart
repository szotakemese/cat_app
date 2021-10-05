import 'package:auto_route/auto_route.dart';
import 'package:cat_app/login/login.dart';
import 'package:cat_app/screens/screens.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginScreen,
      path: '/login',
    ),
    AutoRoute<String>(
      path: '/home',
      page: HomeScreen,
      children: [
        AutoRoute(
          path: 'cats',
          page: EmptyRouterPage,
          name: 'CatsTab',
          children: [
            AutoRoute(path: '', page: CatsScreen),
            AutoRoute(path: ':catId', page: CatDetailScreen),
          ],
        ),
        AutoRoute(
          path: 'favourites',
          page: EmptyRouterPage,
          name: 'FavouritesTab',
          children: [
            AutoRoute(path: '', page: FavouritesScreen),
            AutoRoute(path: ':catId', page: CatDetailScreen),
          ],
        ),
        AutoRoute(
          path: 'profile',
          page: ProfileScreen,
          name: 'ProfileTab',
        ),
        RedirectRoute(path: '*', redirectTo: '/home'),
      ],
    ),
  ],
)
class $AppRouter {}
