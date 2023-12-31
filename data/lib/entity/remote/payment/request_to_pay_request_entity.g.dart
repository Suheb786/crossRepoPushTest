// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_to_pay_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestToPayRequestEntity _$RequestToPayRequestEntityFromJson(
        Map<String, dynamic> json) =>
    RequestToPayRequestEntity(
      ctgyPurp: json['CtgyPurp'] as String?,
      amount: json['Amount'] as num?,
      fromAccount: json['FromAccount'] as String?,
      dbtrBic: json['DbtrBic'] as String?,
      dbtrAcct: json['DbtrAcct'] as String?,
      nickName: json['NickName'] as String? ?? "",
      beneImage: json['BeneImage'] as String? ?? "",
      isFriend: json['IsFriend'] as bool? ?? false,
      dbtrName: json['DbtrName'] as String?,
      memo: json['Memo'] as String?,
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      type: json['Type'] as String? ?? "",
      detCustomerType: json['DetCustomerType'] as String? ?? "",
      dbtrSurname: json['DbtrSurname'] as String? ?? "",
      addressCountry: json['AddressCountry'] as String? ?? "",
      addressCity: json['AddressCity'] as String? ?? "",
      alias: json['Alias'] as String? ?? "",
    );

Map<String, dynamic> _$RequestToPayRequestEntityToJson(
        RequestToPayRequestEntity instance) =>
    <String, dynamic>{
      'FromAccount': instance.fromAccount,
      'DbtrSurname': instance.dbtrSurname,
      'Alias': instance.alias,
      'AddressCity': instance.addressCity,
      'AddressCountry': instance.addressCountry,
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
