// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_activity_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyActivityListEntity _$RequestMoneyActivityListEntityFromJson(
    Map<String, dynamic> json) {
  return RequestMoneyActivityListEntity(
    msgID: json['msgID'] as String? ?? '',
    trxType: json['trxType'] as String? ?? '',
    trxDir: json['trxDir'] as String? ?? '',
    amount: (json['amount'] as num).toDouble(),
    curr: json['curr'] as String? ?? '',
    svcLvl: json['svcLvl'] as String? ?? '',
    ctgyPurp: json['ctgyPurp'] as String? ?? '',
    dbtrAgt: json['dbtrAgt'] as String? ?? '',
    dbtrAcct: json['dbtrAcct'] as String? ?? '',
    dbtrName: json['dbtrName'] as String? ?? '',
    dbtrAddr: json['dbtrAddr'] as String? ?? '',
    dbtrIsIndvl: json['dbtrIsIndvl'] as String? ?? '',
    dbtrRecordID: json['dbtrRecordID'] as String? ?? '',
    dbtrAlias: json['dbtrAlias'] as String? ?? '',
    dbtrMCC: json['dbtrMCC'] as String? ?? '',
    cdtrAgt: json['cdtrAgt'] as String? ?? '',
    cdtrAcct: json['cdtrAcct'] as String? ?? '',
    cdtrName: json['cdtrName'] as String? ?? '',
    cdtrAddr: json['cdtrAddr'] as String? ?? '',
    cdtrIsIndvl: json['cdtrIsIndvl'] as String? ?? '',
    cdtrRecordID: json['cdtrRecordID'] as String? ?? '',
    cdtrAlias: json['cdtrAlias'] as String? ?? '',
    cdtrMCC: json['cdtrMCC'] as String? ?? '',
    instrInfo: json['instrInfo'] as String? ?? '',
    rmtInf: json['rmtInf'] as String? ?? '',
    rgltryRptg: json['rgltryRptg'] as String? ?? '',
    addInfo1: json['addInfo1'] as String? ?? '',
    addInfo2: json['addInfo2'] as String? ?? '',
    addInfo3: json['addInfo3'] as String? ?? '',
    addInfo4: json['addInfo4'] as String? ?? '',
    trxStatus: json['trxStatus'] as String? ?? '',
    trxReason: json['trxReason'] as String? ?? '',
    processFlag: json['processFlag'] as String? ?? '',
    rtpDate: json['rtpDate'] as String? ?? '',
    statusDate: json['statusDate'] as String? ?? '',
    payRefNo: json['payRefNo'] as String? ?? '',
    errorCode: (json['errorCode'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RequestMoneyActivityListEntityToJson(
        RequestMoneyActivityListEntity instance) =>
    <String, dynamic>{
      'addInfo1': instance.addInfo1,
      'addInfo2': instance.addInfo2,
      'addInfo3': instance.addInfo3,
      'addInfo4': instance.addInfo4,
      'amount': instance.amount,
      'cdtrAcct': instance.cdtrAcct,
      'cdtrAddr': instance.cdtrAddr,
      'cdtrAgt': instance.cdtrAgt,
      'cdtrAlias': instance.cdtrAlias,
      'cdtrIsIndvl': instance.cdtrIsIndvl,
      'cdtrMCC': instance.cdtrMCC,
      'cdtrName': instance.cdtrName,
      'cdtrRecordID': instance.cdtrRecordID,
      'ctgyPurp': instance.ctgyPurp,
      'curr': instance.curr,
      'dbtrAcct': instance.dbtrAcct,
      'dbtrAddr': instance.dbtrAddr,
      'dbtrAgt': instance.dbtrAgt,
      'dbtrAlias': instance.dbtrAlias,
      'dbtrIsIndvl': instance.dbtrIsIndvl,
      'dbtrMCC': instance.dbtrMCC,
      'dbtrName': instance.dbtrName,
      'dbtrRecordID': instance.dbtrRecordID,
      'errorCode': instance.errorCode,
      'instrInfo': instance.instrInfo,
      'msgID': instance.msgID,
      'payRefNo': instance.payRefNo,
      'processFlag': instance.processFlag,
      'rgltryRptg': instance.rgltryRptg,
      'rmtInf': instance.rmtInf,
      'rtpDate': instance.rtpDate,
      'statusDate': instance.statusDate,
      'svcLvl': instance.svcLvl,
      'trxDir': instance.trxDir,
      'trxReason': instance.trxReason,
      'trxStatus': instance.trxStatus,
      'trxType': instance.trxType,
    };
