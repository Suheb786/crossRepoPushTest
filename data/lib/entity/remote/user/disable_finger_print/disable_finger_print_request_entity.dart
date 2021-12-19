import 'package:json_annotation/json_annotation.dart';

part "disable_finger_print_request_entity.g.dart";

@JsonSerializable()
class DisableFingerPrintRequestEntity {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  DisableFingerPrintRequestEntity(
      {this.getToken, required this.baseData, this.uniqueId});

  factory DisableFingerPrintRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DisableFingerPrintRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DisableFingerPrintRequestEntityToJson(this);
}
