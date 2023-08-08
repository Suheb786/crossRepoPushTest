// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_settlement_amount_request_entity.g.dart';

@JsonSerializable()
class GetSettlementAmountRequestEntity {
  @JsonKey(name: "Amount")
  final String? Amount;
  @JsonKey(name: "FromCurrency")
  final String? FromCurrency;
  @JsonKey(name: "ToCurrency")
  final String? ToCurrency;

  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  GetSettlementAmountRequestEntity({
    required this.Amount,
    required this.FromCurrency,
    required this.ToCurrency,
    required this.GetToken,
    required this.BaseClass,
  });

  Map<String, dynamic> toJson() => _$GetSettlementAmountRequestEntityToJson(this);

  factory GetSettlementAmountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSettlementAmountRequestEntityFromJson(json);
}
