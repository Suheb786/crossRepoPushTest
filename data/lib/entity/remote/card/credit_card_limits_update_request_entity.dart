import 'package:json_annotation/json_annotation.dart';

part 'credit_card_limits_update_request_entity.g.dart';

@JsonSerializable()
class CreditCardSLimitsUpdateRequestEntity {
  @JsonKey(name: "OnlinePurchase")
  final bool? isOnlinePurchase;
  @JsonKey(name: "OnlinePurchaseLimit")
  final num? onlinePurchase;
  @JsonKey(name: "ATM")
  final bool? isAtmWithdrawal;
  @JsonKey(name: "ATMLimit")
  final num? atmWithdrawal;
  @JsonKey(name: "Merchant")
  final bool? isMerchantsPayments;
  @JsonKey(name: "MerchantLimit")
  final num? merchantsPayments;
  @JsonKey(name: "ContactLessPayment")
  final bool? isContactLessPayments;
  @JsonKey(name: "ContactLessPaymentLimit")
  final num? contactLessPaymentLimit;
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  CreditCardSLimitsUpdateRequestEntity(
      {this.getToken = true,
      this.atmWithdrawal = 0,
      this.merchantsPayments = 0,
      this.onlinePurchase = 0,
      this.isAtmWithdrawal = false,
      this.isMerchantsPayments = false,
      this.isOnlinePurchase = false,
      this.isContactLessPayments = false,
      this.baseData,
      this.secureCode = "",
      this.contactLessPaymentLimit = 0});

  factory CreditCardSLimitsUpdateRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditCardSLimitsUpdateRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardSLimitsUpdateRequestEntityToJson(this);
}
