// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayRequestEntity _$RequestToPayRequestEntityFromJson(
    Map<String, dynamic> json) {
  return RequestToPayRequestEntity(
    ctgyPurp: json['CtgyPurp'] as String?,
    amount: json['Amount'] as num?,
    dbtrBic: json['DbtrBic'] as String?,
    dbtrAcct: json['DbtrAcct'] as String?,
    nickName: json['NickName'] as String?,
    beneImage: json['BeneImage'] as String?,
    isFriend: json['IsFriend'] as bool?,
    dbtrName: json['DbtrName'] as String?,
    memo: json['Memo'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
    type: json['Type'] as String?,
    detCustomerType: json['DetCustomerType'] as String?,
  );
}

Map<String, dynamic> _$RequestToPayRequestEntityToJson(
        RequestToPayRequestEntity instance) =>
    <String, dynamic>{
      'CtgyPurp': instance.ctgyPurp,
      'Amount': instance.amount,
      'DbtrBic': instance.dbtrBic,
      'DbtrAcct': instance.dbtrAcct,
      'DbtrName': instance.dbtrName,
      'Memo': instance.memo,
      'getToken': instance.getToken,
      'BeneImage': instance.beneImage,
      'IsFriend': instance.isFriend,
      'Type': instance.type,
      'DetCustomerType': instance.detCustomerType,
      'NickName': instance.nickName,
      'baseClass': instance.baseData,
    };
