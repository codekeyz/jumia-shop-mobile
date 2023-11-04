import 'package:flutter/material.dart';
import 'package:jumia_shop/pages/product/product_facet_item.dart';
import 'package:jumia_shop/pages/product/product_variant_item.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';
import 'package:jumia_shop/widgets/loader/loader_screen.dart';
import 'package:jumia_shop/widgets/refresh_wrapper.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;
  final String? productSlug;

  final String? productVariantId;

  const ProductDetailScreen({
    Key? key,
    this.productId,
    this.productSlug,
    this.productVariantId,
  })  : assert(productId != null || productSlug != null),
        super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ValueNotifier<ProviderEvent<ProductDetail?>> _detailNotifier =
      ValueNotifier(const ProviderEvent.idle());

  ProductVariant? _selectedVariant;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    final productId = widget.productId;
    final productSlug = widget.productSlug;

    await fetchProduct(id: productId, slug: productSlug);
  }

  Future<void> fetchProduct({String? id, String? slug}) async {
    // try {
    //   final _result = await getIt.get<GraphQLClient>().runQuery(
    //         GetProductRequest(id: id, slug: slug),
    //         resultKey: 'product',
    //       );

    //   final detail = ProductDetail.fromJson(_result!);

    //   setVariant(detail.variants);
    //   _detailNotifier.value = ProviderEvent.success(data: detail);
    // } on NetworkError catch (e) {
    //   _detailNotifier.value = ProviderEvent.error(message: e.message);
    // }
  }

  void setVariant(List<ProductVariant> variants) {
    _selectedVariant = variants.firstWhere(
      (e) => e.id == widget.productVariantId,
      orElse: () => variants.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ValueListenableBuilder<ProviderEvent<ProductDetail?>>(
      valueListenable: _detailNotifier,
      builder: (_, value, c) {
        final productDetail = value.data;
        if (productDetail == null) {
          return LoadingScreen(backgroundColor: Colors.grey.shade400);
        }

        final facetValues = productDetail.facetValues;
        final variants = productDetail.variants;

        final featuredAsset =
            _selectedVariant?.featuredAsset ?? productDetail.featuredAsset;

        return Scaffold(
          appBar: AppBar(
            title: Text(productDetail.name),
          ),
          body: RefreshWrapper(
            onRefresh: init,
            body: Column(
              children: [
                Image.network(
                  featuredAsset.source,
                  height: 280,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productDetail.name,
                        style: themeData.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      if (facetValues.isNotEmpty) ...[
                        SizedBox(
                          width: double.maxFinite,
                          height: 15,
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (_, i) =>
                                const SizedBox(width: 10, child: Text('|')),
                            itemCount: facetValues.length,
                            itemBuilder: (_, i) {
                              final facet = facetValues[i];

                              return ProductFacetItem(
                                facet: facet,
                                onTap: () => {},
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        displayPrice(_selectedVariant!.price),
                        style: themeData.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      if (variants.isNotEmpty) ...[
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: variants
                              .map((e) => ProductVariantItem(
                                  variant: e,
                                  selected: e == _selectedVariant,
                                  onTap: () {
                                    setState(() => _selectedVariant = e);
                                  }))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Material(
                        child: Text(productDetail.description,
                            style: themeData.textTheme.bodyMedium),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 90,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: themeData.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    label: const Text('Add to Cart'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
