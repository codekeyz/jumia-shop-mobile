import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jumia_shop/features/products/products_provider.dart';
import 'package:jumia_shop/pages/widgets/product_item.dart';
import 'package:jumia_shop/router/user_router.gr.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:jumia_shop/widgets/empty_state_screen.dart';
import 'package:jumia_shop/widgets/refresh_wrapper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductsProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProductsProvider>();
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
      body: RefreshWrapper(
        onRefresh: () async {
          _productProvider.fetchProducts(refresh: true);
        },
        body: StreamBuilder<ProviderEvent>(
          stream: _productProvider.stream,
          initialData: _productProvider.lastEvent,
          builder: (_, snap) {
            final data = snap.data;
            final products = _productProvider.products;
            if (products.isEmpty) {
              if (data?.state == ProviderState.loading) {
                return const SizedBox.shrink();
              } else if (data?.state == ProviderState.error) {
                return EmptyStateScreen(
                  onRefresh: () =>
                      _productProvider.fetchProducts(refresh: true),
                  message:
                      data?.message ?? 'An error occurred while fetching data',
                );
              }
            }
            return GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16),
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) => ProductItem(
                product: products[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
