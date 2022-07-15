import 'package:flutter/material.dart';
import 'package:jumia_shop/server/models/category.dart';
import 'package:jumia_shop/widgets/card_with_image.dart';

class CategoryItemParent extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool selected;

  const CategoryItemParent({
    Key? key,
    required this.category,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: selected ? Colors.grey.shade100 : null,
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 60),
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: themeData.textTheme.bodyText2?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItemChild extends StatelessWidget {
  final Category category;

  const CategoryItemChild({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CardWithImage(
      cardWidth: double.maxFinite,
      imageHeight: 50.0,
      title: category.name,
      alignment: CrossAxisAlignment.center,
      imageProvider: NetworkImage(category.featuredAsset?.source ?? ''),
      onTap: () {},
      titleStyle: themeData.textTheme.bodyText2?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      subtitleStyle: themeData.textTheme.headline6?.copyWith(fontSize: 12),
    );
  }
}
