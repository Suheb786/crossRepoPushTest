// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_ticket_payment_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeTicketPaymentRequestEntity _$MakeTicketPaymentRequestEntityFromJson(
    Map<String, dynamic> json) {
  return MakeTicketPaymentRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    referenceNumber: json['ReferenceNumber'] as String?,
    amount: json['Amount'] as String?,
    accountNo: json['AccountNo'] as String?,
  );
}

Map<String, dynamic> _$MakeTicketPaymentRequestEntityToJson(
        MakeTicketPaymentRequestEntity instance) =>
    <String, dynamic>{
      'AccountNo': instance.accountNo,
      'Amount': instance.amount,
      'ReferenceNumber': instance.referenceNumber,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
