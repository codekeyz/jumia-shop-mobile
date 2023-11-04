import 'package:go_router/go_router.dart';
import 'package:jumia_shop/pages/basket_screen.dart';
import 'package:jumia_shop/pages/home_screen.dart';
import 'package:jumia_shop/pages/splash_screen.dart';

final userRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const BasKetScreen(),
    ),
  ],
);
