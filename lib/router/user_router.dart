import 'package:auto_route/auto_route.dart';
import 'package:jumia_shop/pages/home_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: "HomeRoute",
      initial: true,
      page: HomeScreen,
    ),
  ],
)
class $UserRouter {}
