// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_sub_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseSubAccountRequestEntity _$CloseSubAccountRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CloseSubAccountRequestEntity(
      accountNo: json['AccountNo'] as String,
      iban: json['IBAN'] as String,
      baseClass: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool,
    );

Map<String, dynamic> _$CloseSubAccountRequestEntityToJson(
        CloseSubAccountRequestEntity instance) =>
    <String, dynamic>{
      'IBAN': instance.iban,
      'AccountNo': instance.accountNo,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
