import 'package:json_annotation/json_annotation.dart';
import 'package:jumia_shop/server/models/server_asset.dart';
import 'package:jumia_shop/server/models/server_models.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';

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

  factory Product.fromJson(Map<String, dynamic> datamap) => _$ProductFromJson(datamap);

  static _fromJson(Map<String, dynamic> data) {
    return PaginatedModel.fromJson(data, (_) => ProductVariant.fromJson(_ as dynamic));
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

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum ProductSortOrder { asc, desc }

@JsonSerializable(explicitToJson: true)
class ProductSortParameter {
  final ProductSortOrder? id;
  final ProductSortOrder? createdAt;
  final ProductSortOrder? updatedAt;
  final ProductSortOrder? name;

  const ProductSortParameter({
    this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$ProductSortParameterToJson(this)..removeNulls();

  factory ProductSortParameter.fromJson(Map<String, dynamic> datamap) =>
      _$ProductSortParameterFromJson(datamap);
}

@JsonSerializable(explicitToJson: true)
class ProductListOptions {
  final ProductSortParameter sort;

  const ProductListOptions({
    this.sort = const ProductSortParameter(),
  });

  Map<String, dynamic> toJson() => _$ProductListOptionsToJson(this)..removeNulls();

  factory ProductListOptions.fromJson(Map<String, dynamic> datamap) =>
      _$ProductListOptionsFromJson(datamap);
}
