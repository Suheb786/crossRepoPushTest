// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountListEntity _$AccountListEntityFromJson(Map<String, dynamic> json) =>
    AccountListEntity(
      recordId: json['recordId'] as String? ?? '',
      acciban: json['acciban'] as String? ?? '',
      bic: json['bic'] as String? ?? '',
      openingDate: json['openingDate'] as String? ?? '',
      closingDate: json['closingDate'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      type: json['type'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$AccountListEntityToJson(AccountListEntity instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'acciban': instance.acciban,
      'bic': instance.bic,
      'openingDate': instance.openingDate,
      'closingDate': instance.closingDate,
      'currency': instance.currency,
      'type': instance.type,
      'isDefault': instance.isDefault,
    };
