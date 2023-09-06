// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_customer_id_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByCustomerIdEntity _$GetAccountByCustomerIdEntityFromJson(
        Map<String, dynamic> json) =>
    GetAccountByCustomerIdEntity(
      recordId: json['recordId'] as String? ?? '',
      acciban: json['acciban'] as String? ?? '',
      bic: json['bic'] as String? ?? '',
      openingDate: json['openingDate'] ?? '',
      closingDate: json['closingDate'] ?? '',
      currency: json['currency'] as String? ?? '',
      type: json['type'] as String? ?? '',
      accountType: json['accountType'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      isSubAccount: json['isSubAccount'] as bool? ?? false,
      nickName: json['nickName'] as String? ?? '',
    );

Map<String, dynamic> _$GetAccountByCustomerIdEntityToJson(
        GetAccountByCustomerIdEntity instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'acciban': instance.acciban,
      'bic': instance.bic,
      'openingDate': instance.openingDate,
      'closingDate': instance.closingDate,
      'currency': instance.currency,
      'type': instance.type,
      'accountType': instance.accountType,
      'accountNumber': instance.accountNumber,
      'isSubAccount': instance.isSubAccount,
      'nickName': instance.nickName,
    };
