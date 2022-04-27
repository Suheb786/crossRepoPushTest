import 'package:json_annotation/json_annotation.dart';

part "get_placeholder_request_entity.g.dart";

@JsonSerializable()
class GetPlaceholderRequestEntity {
  @JsonKey(name: "PlaceholderId")
  final int placeholderId;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetPlaceholderRequestEntity({required this.baseData, this.placeholderId: 0});

  factory GetPlaceholderRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPlaceholderRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetPlaceholderRequestEntityToJson(this);
}
