// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_result_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayResultRequestEntity _$RequestToPayResultRequestEntityFromJson(
        Map<String, dynamic> json) =>
    RequestToPayResultRequestEntity(
      CustID: json['CustID'] as String,
      OrgnlMsgId: json['OrgnlMsgId'] as String,
      RTPStatus: json['RTPStatus'] as String,
      RejectReason: json['RejectReason'] as String,
      RejectADdInfo: json['RejectADdInfo'] as String,
      otpCode: json['OtpCode'] as String,
      GetToken: json['GetToken'] as bool,
      BaseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RequestToPayResultRequestEntityToJson(
        RequestToPayResultRequestEntity instance) =>
    <String, dynamic>{
      'CustID': instance.CustID,
      'OrgnlMsgId': instance.OrgnlMsgId,
      'RTPStatus': instance.RTPStatus,
      'RejectReason': instance.RejectReason,
      'RejectADdInfo': instance.RejectADdInfo,
      'OtpCode': instance.otpCode,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
