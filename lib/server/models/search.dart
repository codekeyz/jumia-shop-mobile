import 'package:json_annotation/json_annotation.dart';
import 'package:jumia_shop/server/models/category.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/server/models/server_models.dart';
import 'package:jumia_shop/utils/helper_fncs.dart';
import 'package:meta/meta.dart';

part 'search.g.dart';

@JsonSerializable()
class SearchInput {
  final String? term;
  final String? collectionId;

  final bool? inStock;
  final bool? groupByProduct;

  final List<String>? facetValueIds;

  const SearchInput({
    this.term,
    this.collectionId,
    this.facetValueIds,
    this.inStock,
    this.groupByProduct,
  });

  Map<String, dynamic> toJson() => _$SearchInputToJson(this)..removeNulls();

  factory SearchInput.fromJson(Map<String, dynamic> datamap) {
    return _$SearchInputFromJson(datamap);
  }
}

@JsonSerializable()
class SearchResponse extends PaginatedModel<SearchResult> {
  @protected
  final List<dynamic> collections;

  List<Category> get categories =>
      collections.map((e) => Category.fromJson(e['collection'])).toList();

  const SearchResponse(
    final List<SearchResult> items,
    final int totalItems,
    this.collections,
  ) : super(items: items, totalItems: totalItems);

  @override
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

  factory SearchResponse.fromJson(Map<String, dynamic> datamap) {
    return _$SearchResponseFromJson(datamap);
  }
}

@JsonSerializable(explicitToJson: true)
class SearchResult {
  final String productId;
  final String productName;
  final String slug;
  final String productVariantId;
  final String productVariantName;

  @protected
  final Map<String, dynamic>? productAsset;
  @protected
  final Map<String, dynamic>? productVariantAsset;

  String? get preview {
    return (productAsset ?? productVariantAsset ?? {})['preview'];
  }

  final String description;
  final CurrencyCode currencyCode;

  final bool inStock;

  const SearchResult(
    this.productId,
    this.productName,
    this.productVariantId,
    this.productVariantName,
    this.slug, {
    this.productAsset,
    this.productVariantAsset,
    required this.description,
    required this.currencyCode,
    required this.inStock,
  });

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  factory SearchResult.fromJson(Map<String, dynamic> datamap) {
    return _$SearchResultFromJson(datamap);
  }
}
