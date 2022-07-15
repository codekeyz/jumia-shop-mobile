import 'package:json_annotation/json_annotation.dart';
import 'package:jumia_shop/server/models/server_asset.dart';
import 'package:jumia_shop/server/models/server_models.dart';

part 'product.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum CurrencyCode { usd }

@JsonSerializable(explicitToJson: true)
class Product {
  final String id;
  final String slug;
  final String name;
  final String description;

  final ServerAsset featuredAsset;

  @JsonKey(fromJson: _fromJson)
  final PaginatedModel<ProductVariant> variantList;

  const Product(
    this.id,
    this.name,
    this.description, {
    required this.slug,
    required this.featuredAsset,
    required this.variantList,
  });

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson(Map<String, dynamic> datamap) =>
      _$ProductFromJson(datamap);

  static _fromJson(Map<String, dynamic> data) {
    return PaginatedModel.fromJson(
        data, (_) => ProductVariant.fromJson(_ as dynamic));
  }
}

@JsonSerializable(explicitToJson: true)
class ProductVariant {
  final String name;
  final double price;

  final ServerIdRelation product;

  @JsonKey(unknownEnumValue: CurrencyCode.usd, defaultValue: CurrencyCode.usd)
  final CurrencyCode currentCode;

  final DateTime createdAt, updatedAt;

  const ProductVariant(
    this.name,
    this.product,
    this.price, {
    required this.currentCode,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  factory ProductVariant.fromJson(Map<String, dynamic> datamap) {
    return _$ProductVariantFromJson(datamap);
  }
}
