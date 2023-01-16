import 'package:json_annotation/json_annotation.dart';

part "validate_biller_otp_request.g.dart";

@JsonSerializable()
class ValidateBillerOtpRequest {
  @JsonKey(name: "BillerType")
  final String? billerType;
  @JsonKey(name: "Amount")
  final String? amount;
  @JsonKey(name: "CurrencyCode")
  final String? currencyCode;
  @JsonKey(name: "AccountNo")
  final String? accountNo;
  @JsonKey(name: "IsNewBiller")
  final bool? isNewBiller;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ValidateBillerOtpRequest(
      {this.billerType,
      this.amount,
      this.currencyCode,
      this.accountNo,
      this.isNewBiller,
      required this.getToken,
      required this.baseData});

  factory ValidateBillerOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateBillerOtpRequestFromJson(json);

  Map<String?, dynamic> toJson() => _$ValidateBillerOtpRequestToJson(this);
}
