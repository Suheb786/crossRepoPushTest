import 'package:json_annotation/json_annotation.dart';

part "rejection_reason_request_entity.g.dart";

@JsonSerializable()
class RejectionReasonRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  RejectionReasonRequestEntity({
    this.getToken= true,
    this.baseData,
  });

  factory RejectionReasonRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RejectionReasonRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RejectionReasonRequestEntityToJson(this);
}
