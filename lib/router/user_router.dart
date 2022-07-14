import 'package:auto_route/auto_route.dart';
import 'package:jumia_shop/pages/account_screen.dart';
import 'package:jumia_shop/pages/basket_screen.dart';
import 'package:jumia_shop/pages/category_screen.dart';
import 'package:jumia_shop/pages/home_screen.dart';
import 'package:jumia_shop/pages/index_screen.dart';
import 'package:jumia_shop/pages/search_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: "IndexRoute",
      initial: true,
      page: IndexScreen,
      children: [
        AutoRoute(
          initial: true,
          page: HomeScreen,
          name: 'HomeTabRoute',
          path: 'home',
        ),
        AutoRoute(
          page: CategoryScreen,
          name: 'CategoryTabRoute',
          path: 'categories',
        ),
        AutoRoute(
          page: AccountScreen,
          name: 'AccountTabRoute',
          path: 'account',
        )
      ],
    ),
    AutoRoute(
      path: '/search',
      name: "SearchRoute",
      page: SearchScreen,
    ),
    AutoRoute(
      path: '/basket',
      name: "CartRoute",
      page: BasKetScreen,
    )
  ],
)
class $UserRouter {}
