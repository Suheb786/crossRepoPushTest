// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_confirmation_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditConfirmationRequestEntity _$CreditConfirmationRequestEntityFromJson(Map<String, dynamic> json) {
  return CreditConfirmationRequestEntity(
    getToken: json['GetToken'] as bool,
    baseClass: json['BaseClass'] as Map<String, dynamic>,
    custID: json['CustID'] as String,
    msgId: json['MsgId'] as String,
  );
}

Map<String, dynamic> _$CreditConfirmationRequestEntityToJson(CreditConfirmationRequestEntity instance) =>
    <String, dynamic>{
      'MsgId': instance.msgId,
      'CustID': instance.custID,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
