import 'package:json_annotation/json_annotation.dart';
import 'package:jumia_shop/server/models/server_asset.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  final String id;
  final String name;
  final String slug;
  final DateTime createdAt, updatedAt;

  final ServerAsset? featuredAsset;
  final List<Category> children;

  const Category(
    this.id,
    this.name,
    this.slug, {
    required this.createdAt,
    required this.updatedAt,
    this.featuredAsset,
    this.children = const [],
  });

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  factory Category.fromJson(Map<String, dynamic> datamap) => _$CategoryFromJson(datamap);
}
