// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_outward_payment_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitOutwardPaymentRequestEntity _$SubmitOutwardPaymentRequestEntityFromJson(Map<String, dynamic> json) {
  return SubmitOutwardPaymentRequestEntity(
    json['custID'] as String,
    json['dbtrAcct'] as String,
    json['dbtrName'] as String,
    json['dbtrPstlAdr'] as String,
    json['dbtrRecordID'] as String,
    json['dbtrAlias'] as String,
    json['currency'] as String,
    json['amount'] as String,
    json['purposE_CODE'] as String,
    json['cdtrBic'] as String,
    json['cdtrName'] as String,
    json['cdtrAcct'] as String,
    json['cdtrPstlAdr'] as String,
    json['cdtrRecordID'] as String,
    json['cdtrAlias'] as String,
    json['rgltryRptg'] as String,
    json['CustIDTO'] as String,
    json['DbtrIsIndvl'] as String,
    json['CdtrIsIndvl'] as String,
    json['RmtInf'] as String,
    json['QRFlag'] as String,
    json['GetToken'] as bool,
    json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SubmitOutwardPaymentRequestEntityToJson(SubmitOutwardPaymentRequestEntity instance) =>
    <String, dynamic>{
      'custID': instance.custID,
      'dbtrAcct': instance.dbtrAcct,
      'dbtrName': instance.dbtrName,
      'dbtrPstlAdr': instance.dbtrPstlAdr,
      'dbtrRecordID': instance.dbtrRecordID,
      'dbtrAlias': instance.dbtrAlias,
      'currency': instance.currency,
      'amount': instance.amount,
      'purposE_CODE': instance.purposE_CODE,
      'cdtrBic': instance.cdtrBic,
      'cdtrName': instance.cdtrName,
      'cdtrAcct': instance.cdtrAcct,
      'cdtrPstlAdr': instance.cdtrPstlAdr,
      'cdtrRecordID': instance.cdtrRecordID,
      'cdtrAlias': instance.cdtrAlias,
      'rgltryRptg': instance.rgltryRptg,
      'CustIDTO': instance.CustIDTO,
      'DbtrIsIndvl': instance.DbtrIsIndvl,
      'CdtrIsIndvl': instance.CdtrIsIndvl,
      'RmtInf': instance.RmtInf,
      'QRFlag': instance.QRFlag,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
