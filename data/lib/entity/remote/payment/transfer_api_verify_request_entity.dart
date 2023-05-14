import 'package:json_annotation/json_annotation.dart';

part "transfer_api_verify_request_entity.g.dart";

@JsonSerializable()
class TransferApiVerifyRequestEntity {
  @JsonKey(name: "Amount")
  final String? amount;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  TransferApiVerifyRequestEntity({
    this.getToken= true,
    this.baseData,
    this.amount= "",
  });

  factory TransferApiVerifyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferApiVerifyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferApiVerifyRequestEntityToJson(this);
}
