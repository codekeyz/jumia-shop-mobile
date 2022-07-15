import 'package:flutter/material.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';

class ProductVariantItem extends StatelessWidget {
  final ProductVariant variant;
  final bool selected;
  final VoidCallback onTap;

  const ProductVariantItem({
    Key? key,
    required this.variant,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final textColor = selected ? Colors.white : null;
    final bgColor = selected ? Colors.teal : Colors.teal.withOpacity(0.06);
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                variant.name,
                style: themeData.textTheme.bodyText2?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayPrice(variant.price),
                style: themeData.textTheme.headline6?.copyWith(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
          color: bgColor,
          constraints: const BoxConstraints(maxWidth: 100),
        ),
      ),
    );
  }
}
