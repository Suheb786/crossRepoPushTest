// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_rtp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRtpRequestEntity _$UpdateRtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UpdateRtpRequestEntity(
      msgId: json['msgId'] as String?,
      rejectReason: json['rejectReason'] as String?,
      rejectAddInfo: json['rejectAddInfo'] as String?,
      dbtrBic: json['dbtrBic'] as String?,
      dbtrAcct: json['dbtrAcct'] as String?,
      dbtrName: json['dbtrName'] as String?,
      dbtrIsIndvl: json['dbtrIsIndvl'] as String?,
      cdtrBic: json['cdtrBic'] as String?,
      cdtrAcct: json['cdtrAcct'] as String?,
      cdtrName: json['cdtrName'] as String?,
      cdtrIsIndvl: json['cdtrIsIndvl'] as String?,
      rmtInf: json['rmtInf'] as String?,
      ctgyPurp: json['ctgyPurp'] as String?,
      amount: json['amount'] as String?,
      curr: json['curr'] as String?,
      rtpStatus: json['rtpStatus'] as bool?,
      otPcode: json['otPcode'] as String?,
      cdtrPstlAdr: json['cdtrPstlAdr'] as String?,
      dbtrPstlAdr: json['dbtrPstlAdr'] as String?,
      getToken: json['getToken'] as bool?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateRtpRequestEntityToJson(
        UpdateRtpRequestEntity instance) =>
    <String, dynamic>{
      'msgId': instance.msgId,
      'rejectReason': instance.rejectReason,
      'rejectAddInfo': instance.rejectAddInfo,
      'dbtrBic': instance.dbtrBic,
      'dbtrAcct': instance.dbtrAcct,
      'dbtrName': instance.dbtrName,
      'dbtrIsIndvl': instance.dbtrIsIndvl,
      'cdtrBic': instance.cdtrBic,
      'cdtrAcct': instance.cdtrAcct,
      'cdtrName': instance.cdtrName,
      'cdtrIsIndvl': instance.cdtrIsIndvl,
      'rmtInf': instance.rmtInf,
      'ctgyPurp': instance.ctgyPurp,
      'amount': instance.amount,
      'curr': instance.curr,
      'rtpStatus': instance.rtpStatus,
      'otPcode': instance.otPcode,
      'cdtrPstlAdr': instance.cdtrPstlAdr,
      'dbtrPstlAdr': instance.dbtrPstlAdr,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
