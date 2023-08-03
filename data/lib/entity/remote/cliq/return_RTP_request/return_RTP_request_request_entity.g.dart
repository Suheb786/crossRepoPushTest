// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_RTP_request_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnRTPrequestRequestEntity _$ReturnRTPrequestRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ReturnRTPrequestRequestEntity(
      CustID: json['CustID'] as String?,
      MessageID: json['MessageID'] as String?,
      DbtrAcct: json['DbtrAcct'] as String?,
      DbtrName: json['DbtrName'] as String?,
      CdtrAcct: json['CdtrAcct'] as String?,
      CdtrName: json['CdtrName'] as String?,
      Currency: json['Currency'] as String?,
      Amount: (json['Amount'] as num?)?.toDouble(),
      RtrnReason: json['RtrnReason'] as String?,
      RtrnAddInfo: json['RtrnAddInfo'] as String?,
      IsDispute: json['IsDispute'] as bool?,
      DisputeRefNo: json['DisputeRefNo'] as String?,
      OtpCode: json['OtpCode'] as String?,
      GetToken: json['GetToken'] as bool?,
      BaseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReturnRTPrequestRequestEntityToJson(
        ReturnRTPrequestRequestEntity instance) =>
    <String, dynamic>{
      'CustID': instance.CustID,
      'MessageID': instance.MessageID,
      'DbtrAcct': instance.DbtrAcct,
      'DbtrName': instance.DbtrName,
      'CdtrAcct': instance.CdtrAcct,
      'CdtrName': instance.CdtrName,
      'Currency': instance.Currency,
      'Amount': instance.Amount,
      'RtrnReason': instance.RtrnReason,
      'RtrnAddInfo': instance.RtrnAddInfo,
      'IsDispute': instance.IsDispute,
      'DisputeRefNo': instance.DisputeRefNo,
      'OtpCode': instance.OtpCode,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
