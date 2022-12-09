import 'package:json_annotation/json_annotation.dart';

part "send_qr_clip_payment_request_entity.g.dart";

@JsonSerializable()
class SendQrCliqPaymentRequestEntity {
  @JsonKey(name: "referenceLabel")
  final String? referenceLabel;

  @JsonKey(name: "merchantCategoryCode")
  final String? merchantCategoryCode;

  @JsonKey(name: "countryCode")
  final String? countryCode;

  @JsonKey(name: "merchantID")
  final String? merchantID;

  @JsonKey(name: "merchantName")
  final String? merchantName;

  @JsonKey(name: "location")
  final dynamic location;

  @JsonKey(name: "transactionAmount")
  final String? transactionAmount;

  @JsonKey(name: "city")
  final String? city;

  @JsonKey(name: "transactionCurrency")
  final String? transactionCurrency;

  @JsonKey(name: "additionalLanguageTemplate")
  final String? additionalLanguageTemplate;

  @JsonKey(name: "verificationCode")
  final dynamic verificationCode;

  @JsonKey(name: "dateTime")
  final String? dateTime;

  @JsonKey(name: "billNumber")
  final dynamic billNumber;

  @JsonKey(name: "mobileNumber")
  final dynamic mobileNumber;

  @JsonKey(name: "storeLabel")
  final dynamic storeLabel;

  @JsonKey(name: "loyaltyNumber")
  final dynamic loyaltyNumber;

  @JsonKey(name: "customerLabel")
  final dynamic customerLabel;

  @JsonKey(name: "terminalLabel")
  final dynamic terminalLabel;

  @JsonKey(name: "qrCode")
  final String? qrCode;

  @JsonKey(name: "crdtrBic")
  final String? crdtrBic;

  @JsonKey(name: "fromAccount")
  final String? fromAccount;

  @JsonKey(name: "fromAccountHolderName")
  final String? fromAccountHolderName;

  @JsonKey(name: "ValueOfConvenienceFixed")
  final String? ValueOfConvenienceFixed;

  @JsonKey(name: "TipOrConvenienceIndicator")
  final String? TipOrConvenienceIndicator;

  @JsonKey(name: "valueOfPercentageConvenience")
  final dynamic valueOfPercentageConvenience;

  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SendQrCliqPaymentRequestEntity(
      {required this.referenceLabel,
      required this.merchantCategoryCode,
      required this.countryCode,
      required this.merchantID,
      required this.merchantName,
      this.location,
      required this.transactionAmount,
      required this.city,
      required this.transactionCurrency,
      required this.additionalLanguageTemplate,
      this.verificationCode,
      required this.dateTime,
      this.billNumber,
      this.mobileNumber,
      this.storeLabel,
      this.loyaltyNumber,
      this.customerLabel,
      this.terminalLabel,
      required this.qrCode,
      required this.crdtrBic,
      required this.fromAccount,
      required this.fromAccountHolderName,
      required this.ValueOfConvenienceFixed,
      required this.TipOrConvenienceIndicator,
      this.valueOfPercentageConvenience,
      required this.getToken,
      required this.baseData});

  factory SendQrCliqPaymentRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SendQrCliqPaymentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendQrCliqPaymentRequestEntityToJson(this);
}
