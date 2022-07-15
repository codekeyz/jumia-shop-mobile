import 'package:json_annotation/json_annotation.dart';
part 'server_asset.g.dart';

@JsonSerializable(explicitToJson: true)
class ServerAsset {
  final String name;
  final String type;
  final String source;

  const ServerAsset(this.name, this.type, this.source);

  Map<String, dynamic> toJson() => _$ServerAssetToJson(this);

  factory ServerAsset.fromJson(Map<String, dynamic> datamap) =>
      _$ServerAssetFromJson(datamap);
}
