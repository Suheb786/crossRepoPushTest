// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'place_order_request_entity.g.dart';

@JsonSerializable()
class PlaceOrderRequestEntity {
  @JsonKey(name: "sourceAccount", defaultValue: "")
  final String? sourceAccount;
  @JsonKey(name: "sourceCurrency", defaultValue: "")
  final String? sourceCurrency;
  @JsonKey(name: "cardItemId", defaultValue: "")
  final String? cardItemId;
  @JsonKey(name: "exchangeRate", defaultValue: 0.0)
  final double? exchangeRate;
  @JsonKey(name: "VoucherCurrency", defaultValue: "")
  final String? voucherCurrency;
  @JsonKey(name: "reconciliationCurrency", defaultValue: "")
  final String? reconciliationCurrency;
  @JsonKey(name: "EquivalentAmount", defaultValue: "0.0")
  final String? equivalentAmount;
  @JsonKey(name: "Denomination", defaultValue: 0)
  final int? denomination;
  @JsonKey(name: "Discount", defaultValue: "")
  final String? discount;
  @JsonKey(name: "Categories", defaultValue: "")
  final String? categories;
  @JsonKey(name: "VoucherName", defaultValue: "")
  final String? voucherName;
  @JsonKey(name: "ProductId", defaultValue: "")
  final String? productId;
  @JsonKey(name: "ProductName", defaultValue: "")
  final String? productName;
  @JsonKey(name: "OtpCode", defaultValue: "")
  final String? otpCode;
  @JsonKey(name: "GetToken", defaultValue: false)
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  PlaceOrderRequestEntity({
    required this.sourceAccount,
    required this.sourceCurrency,
    required this.cardItemId,
    required this.exchangeRate,
    required this.voucherCurrency,
    required this.reconciliationCurrency,
    required this.equivalentAmount,
    required this.denomination,
    required this.discount,
    required this.categories,
    required this.voucherName,
    required this.productId,
    required this.productName,
    required this.otpCode,
    required this.getToken,
    required this.BaseClass,
  });

  Map<String, dynamic> toJson() => _$PlaceOrderRequestEntityToJson(this);

  factory PlaceOrderRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderRequestEntityFromJson(json);
}
