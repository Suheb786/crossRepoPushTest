// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayContentEntity _$RequestToPayContentEntityFromJson(Map<String, dynamic> json) {
  return RequestToPayContentEntity(
    custID: json['custID'] as String?,
    senderName: json['senderName'] as String?,
    senderPstlAdr: json['senderPstlAdr'] as String?,
    dbtrBic: json['dbtrBic'] as String?,
    dbtrAcct: json['dbtrAcct'] as String?,
    dbtrName: json['dbtrName'] as String?,
    dbtrPstlAdr: json['dbtrPstlAdr'] as String?,
    dbtrIsIndvl: json['dbtrIsIndvl'] as String?,
    dbtrRecordID: json['dbtrRecordID'] as String?,
    dbtrAlias: json['dbtrAlias'] as String?,
    dbtrMCC: json['dbtrMCC'] as String?,
    cdtrAcct: json['cdtrAcct'] as String?,
    cdtrName: json['cdtrName'] as String?,
    cdtrPstlAdr: json['cdtrPstlAdr'] as String?,
    cdtrIsIndvl: json['cdtrIsIndvl'] as String?,
    cdtrRecordID: json['cdtrRecordID'] as String?,
    cdtrAlias: json['cdtrAlias'] as String?,
    cdtrMCC: json['cdtrMCC'] as String?,
    instrInf: json['instrInf'] as String?,
    rgltryRptg: json['rgltryRptg'] as String?,
    rmtInf: json['rmtInf'] as String?,
    ctgyPurp: json['ctgyPurp'] as String?,
    curr: json['curr'] as String?,
    amount: json['amount'] as String?,
    payRefNo: json['payRefNo'] as String?,
  );
}

Map<String, dynamic> _$RequestToPayContentEntityToJson(RequestToPayContentEntity instance) =>
    <String, dynamic>{
      'custID': instance.custID,
      'senderName': instance.senderName,
      'senderPstlAdr': instance.senderPstlAdr,
      'dbtrBic': instance.dbtrBic,
      'dbtrAcct': instance.dbtrAcct,
      'dbtrName': instance.dbtrName,
      'dbtrPstlAdr': instance.dbtrPstlAdr,
      'dbtrIsIndvl': instance.dbtrIsIndvl,
      'dbtrRecordID': instance.dbtrRecordID,
      'dbtrAlias': instance.dbtrAlias,
      'dbtrMCC': instance.dbtrMCC,
      'cdtrAcct': instance.cdtrAcct,
      'cdtrName': instance.cdtrName,
      'cdtrPstlAdr': instance.cdtrPstlAdr,
      'cdtrIsIndvl': instance.cdtrIsIndvl,
      'cdtrRecordID': instance.cdtrRecordID,
      'cdtrAlias': instance.cdtrAlias,
      'cdtrMCC': instance.cdtrMCC,
      'instrInf': instance.instrInf,
      'rgltryRptg': instance.rgltryRptg,
      'rmtInf': instance.rmtInf,
      'ctgyPurp': instance.ctgyPurp,
      'curr': instance.curr,
      'amount': instance.amount,
      'payRefNo': instance.payRefNo,
    };
