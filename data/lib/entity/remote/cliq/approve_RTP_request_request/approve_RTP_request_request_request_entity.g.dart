// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_RTP_request_request_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRTPRequestReqestEntity _$ApproveRTPRequestReqestEntityFromJson(
    Map<String, dynamic> json) {
  return ApproveRTPRequestReqestEntity(
    dbtrName: json['dbtrName'] as String,
    dbtrPstlAdr: json['dbtrPstlAdr'] as String,
    dbtrRecordID: json['dbtrRecordID'] as String,
    dbtrAlias: json['dbtrAlias'] as String,
    currency: json['currency'] as String,
    amount: json['amount'] as String,
    cdtrBic: json['cdtrBic'] as String,
    cdtrName: json['cdtrName'] as String,
    cdtrAcct: json['cdtrAcct'] as String,
    cdtrPstlAdr: json['cdtrPstlAdr'] as String,
    cdtrRecordID: json['cdtrRecordID'] as String,
    cdtrAlias: json['cdtrAlias'] as String,
    rgltryRptg: json['rgltryRptg'] as String,
    payRefNo: json['payRefNo'] as String,
    OrgnlMsgId: json['OrgnlMsgId'] as String,
    CtgyPurp: json['CtgyPurp'] as String,
    rejectReason: json['rejectReason'] as String,
    rejectADdInfo: json['rejectADdInfo'] as String,
    rtpStatus: json['rtpStatus'] as String,
    GetToken: json['GetToken'] as bool,
    BaseClass: json['BaseClass'] as Map<String, dynamic>,
    custID: json['custID'] as String,
    dbtrAcct: json['dbtrAcct'] as String,
  );
}

Map<String, dynamic> _$ApproveRTPRequestReqestEntityToJson(
        ApproveRTPRequestReqestEntity instance) =>
    <String, dynamic>{
      'custID': instance.custID,
      'dbtrAcct': instance.dbtrAcct,
      'dbtrName': instance.dbtrName,
      'dbtrPstlAdr': instance.dbtrPstlAdr,
      'dbtrRecordID': instance.dbtrRecordID,
      'dbtrAlias': instance.dbtrAlias,
      'currency': instance.currency,
      'amount': instance.amount,
      'cdtrBic': instance.cdtrBic,
      'cdtrName': instance.cdtrName,
      'cdtrAcct': instance.cdtrAcct,
      'cdtrPstlAdr': instance.cdtrPstlAdr,
      'cdtrRecordID': instance.cdtrRecordID,
      'cdtrAlias': instance.cdtrAlias,
      'rgltryRptg': instance.rgltryRptg,
      'payRefNo': instance.payRefNo,
      'OrgnlMsgId': instance.OrgnlMsgId,
      'CtgyPurp': instance.CtgyPurp,
      'rejectReason': instance.rejectReason,
      'rejectADdInfo': instance.rejectADdInfo,
      'rtpStatus': instance.rtpStatus,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
