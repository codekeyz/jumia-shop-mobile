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
class ProductDetail extends Product {
  final List<ServerAsset> assets;
  final List<ProductCategory> collections;
  final List<ProductOptionGroup> optionGroups;
  final List<ServerValue> facetValues;
  final List<ProductVariant> variants;

  ProductDetail(
    final String id,
    final String name,
    final String description,
    final String slug,
    final ServerAsset featuredAsset, {
    this.assets = const [],
    this.collections = const [],
    this.optionGroups = const [],
    this.facetValues = const [],
    this.variants = const [],
  }) : super(
          id,
          name,
          description,
          slug: slug,
          featuredAsset: featuredAsset,
          variantList: const PaginatedModel<ProductVariant>(),
        );

  @override
  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

  factory ProductDetail.fromJson(Map<String, dynamic> datamap) {
    return _$ProductDetailFromJson(datamap);
  }
}

@JsonSerializable(explicitToJson: true)
class ProductCategory {
  final String id;
  final String name;
  final String slug;

  const ProductCategory(this.name, this.slug, this.id);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

  factory ProductCategory.fromJson(Map<String, dynamic> datamap) {
    return _$ProductCategoryFromJson(datamap);
  }
}

@JsonSerializable(explicitToJson: true)
class ProductVariant {
  final String name;
  final double price;
  final String? stockLevel;
  final ServerAsset? featuredAsset;

  final ServerIdRelation product;

  @JsonKey(unknownEnumValue: CurrencyCode.usd, defaultValue: CurrencyCode.usd)
  final CurrencyCode currentCode;

  final DateTime createdAt, updatedAt;

  const ProductVariant(
    this.name,
    this.product,
    this.price, {
    this.featuredAsset,
    this.stockLevel,
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

@JsonSerializable(explicitToJson: true)
class FacetValue extends ServerValue {
  FacetValue(String id, String name) : super(id, name);

  @override
  Map<String, dynamic> toJson() => _$FacetValueToJson(this)..removeNulls();

  factory FacetValue.fromJson(Map<String, dynamic> datamap) => _$FacetValueFromJson(datamap);
}

@JsonSerializable(explicitToJson: true)
class ProductOption extends ServerValue {
  final String groupId;

  const ProductOption(
    String id,
    String name,
    this.groupId,
  ) : super(id, name);

  @override
  Map<String, dynamic> toJson() => _$ProductOptionToJson(this)..removeNulls();

  factory ProductOption.fromJson(Map<String, dynamic> datamap) => _$ProductOptionFromJson(datamap);
}

@JsonSerializable(explicitToJson: true)
class ProductOptionGroup {
  final String name;
  final List<ProductOption> options;

  const ProductOptionGroup(this.name, {this.options = const []});

  Map<String, dynamic> toJson() => _$ProductOptionGroupToJson(this)..removeNulls();

  factory ProductOptionGroup.fromJson(Map<String, dynamic> datamap) =>
      _$ProductOptionGroupFromJson(datamap);
}
