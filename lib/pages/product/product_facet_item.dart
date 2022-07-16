import 'package:flutter/material.dart';
import 'package:jumia_shop/server/models/server_models.dart';

class ProductFacetItem extends StatelessWidget {
  final ServerValue facet;
  final VoidCallback onTap;

  const ProductFacetItem({
    Key? key,
    required this.facet,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          facet.name,
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
