// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'place_order_request_entity.g.dart';

@JsonSerializable()
class PlaceOrderRequestEntity {
  @JsonKey(name: "sourceAccount", defaultValue: "")
  String sourceAccount;
  @JsonKey(name: "sourceCurrency", defaultValue: "")
  String sourceCurrency;
  @JsonKey(name: "cardItemId", defaultValue: "")
  String cardItemId;
  @JsonKey(name: "exchangeRate", defaultValue: 0.0)
  double exchangeRate;
  @JsonKey(name: "VoucherCurrency", defaultValue: "")
  String voucherCurrency;
  @JsonKey(name: "reconciliationCurrency", defaultValue: "")
  String reconciliationCurrency;
  @JsonKey(name: "EquivalentAmount", defaultValue: "0.0")
  String equivalentAmount;
  @JsonKey(name: "Denomination", defaultValue: 0)
  int denomination;
  @JsonKey(name: "Discount", defaultValue: "")
  String discount;
  @JsonKey(name: "Categories", defaultValue: "")
  String categories;
  @JsonKey(name: "VoucherName", defaultValue: "")
  String voucherName;
  @JsonKey(name: "ProductId", defaultValue: "")
  String productId;
  @JsonKey(name: "ProductName", defaultValue: "")
  String productName;
  @JsonKey(name: "OtpCode", defaultValue: "")
  String otpCode;
  @JsonKey(name: "GetToken", defaultValue: false)
  bool getToken;
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
