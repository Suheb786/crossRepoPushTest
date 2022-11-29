// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_send_money_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckSendMoneyRequestEntity _$CheckSendMoneyRequestEntityFromJson(Map<String, dynamic> json) {
  return CheckSendMoneyRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    toAccount: json['ToAccount'] as String?,
    toAmount: json['ToAmount'] as num?,
    getToken: json['getToken'] as bool,
  );
}

Map<String, dynamic> _$CheckSendMoneyRequestEntityToJson(CheckSendMoneyRequestEntity instance) =>
    <String, dynamic>{
      'ToAccount': instance.toAccount,
      'ToAmount': instance.toAmount,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
