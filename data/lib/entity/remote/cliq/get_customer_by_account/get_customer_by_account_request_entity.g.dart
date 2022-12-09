// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_by_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomByAccountRequestEntity _$GetCustomByAccountRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetCustomByAccountRequestEntity(
    accountCode: json['accountCode'] as String?,
    CustID: json['CustID'] as String?,
    GetToken: json['GetToken'] as bool?,
    BaseClass: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetCustomByAccountRequestEntityToJson(
        GetCustomByAccountRequestEntity instance) =>
    <String, dynamic>{
      'accountCode': instance.accountCode,
      'CustID': instance.CustID,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
