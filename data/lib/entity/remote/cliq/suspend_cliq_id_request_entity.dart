import 'package:json_annotation/json_annotation.dart';

part "suspend_cliq_id_request_entity.g.dart";

@JsonSerializable()
class SuspendCliqIdRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;

  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SuspendCliqIdRequestEntity({required this.aliasId, required this.getToken, required this.baseData});

  factory SuspendCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SuspendCliqIdRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendCliqIdRequestEntityToJson(this);
}
