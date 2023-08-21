import 'package:json_annotation/json_annotation.dart';

part 'cc_update_settlement_request_entity.g.dart';

@JsonSerializable()
class CcUpdateSettlementRequestEntity {
  @JsonKey(name: "Rate")
  final num? rate;
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "IssuedFromCms")
  final bool? issuedFromCms;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CcUpdateSettlementRequestEntity(
      {required this.baseData,
      this.getToken = true,
      this.cardId,
      this.rate,
      this.secureCode = '',
      this.issuedFromCms = false});

  factory CcUpdateSettlementRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CcUpdateSettlementRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CcUpdateSettlementRequestEntityToJson(this);
}
