import 'package:json_annotation/json_annotation.dart';

part "purpose_request_entity.g.dart";

@JsonSerializable()
class PurposeRequestEntity {
  @JsonKey(name: "ToAccount")
  final String? toAccount;
  @JsonKey(name: "TransferType")
  final String? transferType;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  PurposeRequestEntity(
      {required this.baseData,
      this.toAccount,
      this.transferType,
      this.getToken: true});

  factory PurposeRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PurposeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeRequestEntityToJson(this);
}
