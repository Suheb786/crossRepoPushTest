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
    dbtrName: json['DbtrName'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
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
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
