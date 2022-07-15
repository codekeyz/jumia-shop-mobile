import 'package:flutter/material.dart';
import 'package:jumia_shop/features/categories/category_provider.dart';
import 'package:jumia_shop/features/products/products_provider.dart';
import 'package:jumia_shop/features/search_provider.dart';
import 'package:jumia_shop/router/user_router.gr.dart';
import 'package:jumia_shop/server/services/injector.dart';
import 'package:jumia_shop/widgets/loader/loader_controller.dart';
import 'package:jumia_shop/widgets/loader/loader_screen.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider<LoaderController>(create: (_) => LoaderController()),
        ChangeNotifierProvider<ProductsProvider>(create: (_) => ProductsProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
      ],
      child: child,
    );
  }
}

void main() async {
  await registerServices();

  runApp(_AppDataProviders(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final userRouter = UserRouter();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: userRouter.defaultRouteParser(),
      routerDelegate: userRouter.delegate(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Boilerplate',
      builder: (_, child) {
        return LoaderWrapper(child: child!);
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.white,
        splashColor: Colors.white,
        canvasColor: Colors.white,
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
