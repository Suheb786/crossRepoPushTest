// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_settlement_amount_request_entity.g.dart';

@JsonSerializable()
class GetSettlementAmountRequestEntity {
  @JsonKey(name: "Denomination")
  final String? Denomination;
  @JsonKey(name: "exchangeRate")
  final String? exchangeRate;
  @JsonKey(name: "reconcilationCurrency")
  final String? reconcilationCurrency;
  @JsonKey(name: "Discount")
  final String? Discount;
  @JsonKey(name: "VoucherName")
  final String? VoucherName;
  @JsonKey(name: "VoucherCategory")
  final String? VoucherCategory;
  @JsonKey(name: "AccountNo")
  final String? AccountNo;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;
  GetSettlementAmountRequestEntity({
    required this.Denomination,
    required this.exchangeRate,
    required this.reconcilationCurrency,
    required this.Discount,
    required this.VoucherName,
    required this.VoucherCategory,
    required this.AccountNo,
    required this.GetToken,
    required this.BaseClass,
  });

  Map<String, dynamic> toJson() => _$GetSettlementAmountRequestEntityToJson(this);
  factory GetSettlementAmountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSettlementAmountRequestEntityFromJson(json);
}
