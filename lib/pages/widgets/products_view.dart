import 'package:flutter/material.dart';
import 'package:jumia_shop/features/products/products_provider.dart';
import 'package:jumia_shop/pages/widgets/product_item.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:jumia_shop/widgets/empty_state_screen.dart';
import 'package:jumia_shop/widgets/refresh_wrapper.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  final ProductListOptions? options;

  const ProductsView({
    Key? key,
    this.options,
  }) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late ProductsProvider _productProvider;

  Future<void> fetchProducts() async {
    return await _productProvider.fetchProducts(
      refresh: true,
      options: const ProductListOptions(
        sort: ProductSortParameter(name: ProductSortOrder.asc),
      ),
    );
  }

  @override
  void initState() {
    _productProvider = context.read<ProductsProvider>();
    super.initState();

    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProductsProvider>();
    return StreamBuilder<ProviderEvent>(
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
              onRefresh: fetchProducts,
              message: data?.message ?? 'An error occurred while fetching data',
            );
          }
        }

        return RefreshWrapper(
          onRefresh: () => fetchProducts(),
          buildScrollParent: (_) {
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
        );
      },
    );
  }
}
