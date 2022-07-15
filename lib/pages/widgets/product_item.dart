import 'package:flutter/material.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';
import 'package:jumia_shop/widgets/card_with_image.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
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
      onTap: () {},
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
