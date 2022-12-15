import 'package:json_annotation/json_annotation.dart';

part "make_ticket_payment_request_entity.g.dart";

@JsonSerializable()
class MakeTicketPaymentRequestEntity {
  @JsonKey(name: "AccountNo")
  final String? accountNo;
  @JsonKey(name: "Amount")
  final String? amount;
  @JsonKey(name: "ReferenceNumber")
  final String? referenceNumber;
  @JsonKey(name: "Otp")
  final String? otpCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  MakeTicketPaymentRequestEntity(
      {required this.baseData,
      this.getToken: true,
      this.referenceNumber,
      this.amount,
      this.accountNo,
      this.otpCode});

  factory MakeTicketPaymentRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$MakeTicketPaymentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MakeTicketPaymentRequestEntityToJson(this);
}
