import 'package:flutter/material.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/server/models/search.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';
import 'package:jumia_shop/widgets/card_with_image.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final variant = product.variantList.items.first;
    final themeData = Theme.of(context);

    return CardWithImage(
      cardWidth: double.maxFinite,
      imageHeight: 50.0,
      title: variant.name,
      alignment: CrossAxisAlignment.center,
      imageProvider: NetworkImage(product.featuredAsset.source),
      onTap: onTap,
      titleStyle: themeData.textTheme.bodyText2?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      subtitleStyle: themeData.textTheme.headline6?.copyWith(fontSize: 12),
      description: displayPrice(
        variant.price,
        currency: variant.currentCode.enumName,
      ),
    );
  }
}

class ProductSearchItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const ProductSearchItem({
    Key? key,
    required this.result,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CardWithImage(
      cardWidth: double.maxFinite,
      imageHeight: 50.0,
      title: result.productName,
      alignment: CrossAxisAlignment.center,
      imageProvider: NetworkImage(result.preview!),
      onTap: onTap,
      titleStyle: themeData.textTheme.bodyText2?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      subtitleStyle: themeData.textTheme.headline6?.copyWith(fontSize: 12),
      description: result.description,
    );
  }
}
