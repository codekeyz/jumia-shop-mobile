import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jumia_shop/pages/widgets/products_view.dart';
import 'package:jumia_shop/router/user_router.gr.dart';
import 'package:jumia_shop/server/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/logo_name.png'),
        actions: [
          IconButton(
            onPressed: () => AutoRouter.of(context).push(
              const CartRoute(),
            ),
            splashRadius: 20,
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => AutoRouter.of(context).push(
                    const SearchRoute(),
                  ),
                  child: const TextField(
                    autofocus: false,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Searching for products, brands',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: const ProductsView(
        options: ProductListOptions(
          sort: ProductSortParameter(name: ProductSortOrder.desc),
        ),
      ),
    );
  }
}
