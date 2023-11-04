import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumia_shop/features/auth_provider.dart';
import 'package:jumia_shop/features/category_provider.dart';
import 'package:jumia_shop/features/products_provider.dart';
import 'package:jumia_shop/features/search_provider.dart';
import 'package:jumia_shop/pages/splash_screen.dart';
import 'package:jumia_shop/router/user_router.dart';
import 'package:jumia_shop/server/services/injector.dart';
import 'package:jumia_shop/widgets/loader/loader_controller.dart';
import 'package:jumia_shop/widgets/loader/loader_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

class _AppDataProviders extends StatelessWidget {
  final Widget child;

  const _AppDataProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoaderController>(
            create: (_) => LoaderController()),
        ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: child,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await registerServices();

  runApp(_AppDataProviders(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: userRouter,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Boilerplate',
      builder: (_, child) {
        return LoaderWrapper(child: child!);
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: const ColorScheme.light(),
        splashColor: Colors.white,
        canvasColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        fontFamily: 'Rubik',
      ),
    );
  }
}
