// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_send_money_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckSendMoneyRequestEntity _$CheckSendMoneyRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CheckSendMoneyRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      fromAccount: json['FromAccount'] as String? ?? "",
      toAccount: json['ToAccount'] as String? ?? '',
      toAmount: json['ToAmount'] as num? ?? 0,
      getToken: json['getToken'] as bool? ?? true,
      beneficiaryId: json['BeneficiaryId'] as String? ?? '',
    );

Map<String, dynamic> _$CheckSendMoneyRequestEntityToJson(
        CheckSendMoneyRequestEntity instance) =>
    <String, dynamic>{
      'FromAccount': instance.fromAccount,
      'ToAccount': instance.toAccount,
      'ToAmount': instance.toAmount,
      'getToken': instance.getToken,
      'BeneficiaryId': instance.beneficiaryId,
      'baseClass': instance.baseData,
    };
