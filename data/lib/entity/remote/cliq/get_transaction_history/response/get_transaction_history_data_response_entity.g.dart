// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_history_data_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionHistoryDataResponseEntity
    _$GetTransactionHistoryDataResponseEntityFromJson(
        Map<String, dynamic> json) {
  return GetTransactionHistoryDataResponseEntity(
    msgID: json['msgID'] as String?,
    trxType: json['trxType'] as String,
    trxDir: json['trxDir'] as String?,
    dbtrAgt: json['dbtrAgt'] as String?,
    cdtrAgt: json['cdtrAgt'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    curr: json['curr'] as String?,
    dbtrAcct: json['dbtrAcct'] as String?,
    cdtrAcct: json['cdtrAcct'] as String?,
    creDtTm: json['creDtTm'] as String?,
    intrBkSttlmDt: json['intrBkSttlmDt'] as String?,
    ctgyPurp: json['ctgyPurp'] as String?,
    rmtInf: json['rmtInf'] as String?,
    rgltryRptg: json['rgltryRptg'] as String?,
    dbtrName: json['dbtrName'] as String?,
    dbtrAddr: json['dbtrAddr'] as String?,
    dbtrRecordID: json['dbtrRecordID'] as String?,
    dbtrAlias: json['dbtrAlias'] as String?,
    dbtrMCC: json['dbtrMCC'] as String?,
    cdtrName: json['cdtrName'] as String?,
    cdtrAddr: json['cdtrAddr'] as String?,
    cdtrRecordID: json['cdtrRecordID'] as String?,
    cdtrAlias: json['cdtrAlias'] as String?,
    cdtrMCC: json['cdtrMCC'] as String?,
    addInfo1: json['addInfo1'] as String?,
    addInfo2: json['addInfo2'] as String?,
    addInfo3: json['addInfo3'] as String?,
    addInfo4: json['addInfo4'] as String?,
    trxStatus: json['trxStatus'] as String?,
    trxReason: json['trxReason'] as String?,
    payRefNo: json['payRefNo'] as String?,
    errorCode: (json['errorCode'] as num?)?.toDouble(),
    paymentDate: json['paymentDate'] as String?,
    allowReturn: json['allowReturn'] as bool?,
    returnAmount: json['returnAmount'] as String?,
    returnStatus: json['returnStatus'] as bool?,
    returnDate: json['returnDate'] as String?,
    isFullReturn: json['isFullReturn'] as bool?,
  );
}

Map<String, dynamic> _$GetTransactionHistoryDataResponseEntityToJson(
        GetTransactionHistoryDataResponseEntity instance) =>
    <String, dynamic>{
      'msgID': instance.msgID,
      'trxType': instance.trxType,
      'trxDir': instance.trxDir,
      'dbtrAgt': instance.dbtrAgt,
      'cdtrAgt': instance.cdtrAgt,
      'amount': instance.amount,
      'curr': instance.curr,
      'dbtrAcct': instance.dbtrAcct,
      'cdtrAcct': instance.cdtrAcct,
      'creDtTm': instance.creDtTm,
      'intrBkSttlmDt': instance.intrBkSttlmDt,
      'ctgyPurp': instance.ctgyPurp,
      'rmtInf': instance.rmtInf,
      'rgltryRptg': instance.rgltryRptg,
      'dbtrName': instance.dbtrName,
      'dbtrAddr': instance.dbtrAddr,
      'dbtrRecordID': instance.dbtrRecordID,
      'dbtrAlias': instance.dbtrAlias,
      'dbtrMCC': instance.dbtrMCC,
      'cdtrName': instance.cdtrName,
      'cdtrAddr': instance.cdtrAddr,
      'cdtrRecordID': instance.cdtrRecordID,
      'cdtrAlias': instance.cdtrAlias,
      'cdtrMCC': instance.cdtrMCC,
      'addInfo1': instance.addInfo1,
      'addInfo2': instance.addInfo2,
      'addInfo3': instance.addInfo3,
      'addInfo4': instance.addInfo4,
      'trxStatus': instance.trxStatus,
      'trxReason': instance.trxReason,
      'payRefNo': instance.payRefNo,
      'errorCode': instance.errorCode,
      'paymentDate': instance.paymentDate,
      'allowReturn': instance.allowReturn,
      'returnAmount': instance.returnAmount,
      'returnStatus': instance.returnStatus,
      'returnDate': instance.returnDate,
      'isFullReturn': instance.isFullReturn,
    };
