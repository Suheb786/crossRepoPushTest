import 'package:json_annotation/json_annotation.dart';

part 'pay_prepaid_bill_request.g.dart';

@JsonSerializable()
class PayPrePaidRequest {
  @JsonKey(name: "billerCode")
  final String? billerCode;
  @JsonKey(name: "billerName")
  final String? billerName;
  @JsonKey(name: "billingNumber")
  final String? billingNumber;
  @JsonKey(name: "serviceType")
  final String? serviceType;
  @JsonKey(name: "amount")
  String? amount;
  @JsonKey(name: "currencyCode")
  final String? currencyCode;
  @JsonKey(name: "accountNo")
  final String? accountNo;
  @JsonKey(name: "isNewBiller")
  final bool? isNewBiller;
  @JsonKey(name: "otpCode")
  final String? otpCode;
  @JsonKey(name: "prepaidCategoryCode")
  final String? prepaidCategoryCode;
  @JsonKey(name: "prepaidCategoryType")
  final String? prepaidCategoryType;
  @JsonKey(name: "billingNumberRequired")
  final bool? billingNumberRequired;
  @JsonKey(name: "isCreditCardPayment")
  final bool? isCreditCardPayment;
  @JsonKey(name: "CardId")
  final String? CardId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  PayPrePaidRequest(
      {this.billerCode,
      this.billerName,
      this.billingNumber,
      this.serviceType,
      // this.categoryCode,
      this.amount,
      this.currencyCode,
      this.accountNo,
      this.isNewBiller,
      this.otpCode,
      this.CardId,
      this.prepaidCategoryCode,
      this.prepaidCategoryType,
      this.billingNumberRequired,
      this.isCreditCardPayment,
      this.getToken,
      required this.baseData});

  factory PayPrePaidRequest.fromJson(Map<String, dynamic> json) =>
      _$PayPrePaidRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayPrePaidRequestToJson(this);
}
