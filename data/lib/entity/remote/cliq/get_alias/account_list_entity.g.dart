// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountListEntity _$AccountListEntityFromJson(Map<String, dynamic> json) {
  return AccountListEntity(
    accountID: json['accountID'] as String? ?? '',
    identifier: json['identifier'] as String? ?? '',
    isDefault: json['isDefault'] as bool? ?? false,
  );
}

Map<String, dynamic> _$AccountListEntityToJson(AccountListEntity instance) =>
    <String, dynamic>{
      'accountID': instance.accountID,
      'identifier': instance.identifier,
      'isDefault': instance.isDefault,
    };
