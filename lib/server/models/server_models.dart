import 'package:json_annotation/json_annotation.dart';

part 'server_models.g.dart';

typedef FJson<T> = T Function(Object? json);

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class PaginatedModel<T> {
  final List<T> items;
  final int totalItems;

  const PaginatedModel({this.items = const [], this.totalItems = 0});

  Map<String, dynamic> toJson() => _$PaginatedModelToJson(
        this,
        (v) => (v as dynamic).toJson(),
      );

  factory PaginatedModel.fromJson(Map<String, dynamic> datamap, FJson<T> parse) =>
      _$PaginatedModelFromJson(datamap, parse);
}

@JsonSerializable(explicitToJson: true)
class ServerIdRelation {
  final String id;

  const ServerIdRelation(this.id);
  Map<String, dynamic> toJson() => _$ServerIdRelationToJson(this);

  factory ServerIdRelation.fromJson(Map<String, dynamic> datamap) =>
      _$ServerIdRelationFromJson(datamap);
}

@JsonSerializable(explicitToJson: true)
class ServerValue {
  final String id;
  final String name;

  const ServerValue(this.id, this.name);

  Map<String, dynamic> toJson() => _$ServerValueToJson(this);

  factory ServerValue.fromJson(Map<String, dynamic> datamap) => _$ServerValueFromJson(datamap);
}
