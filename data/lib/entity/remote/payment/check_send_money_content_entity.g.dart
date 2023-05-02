// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_send_money_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckSendMoneyContentEntity _$CheckSendMoneyContentEntityFromJson(
        Map<String, dynamic> json) =>
    CheckSendMoneyContentEntity(
      transferResponse: json['transferResponse'] == null
          ? null
          : TransferResponseEntity.fromJson(
              json['transferResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckSendMoneyContentEntityToJson(
        CheckSendMoneyContentEntity instance) =>
    <String, dynamic>{
      'transferResponse': instance.transferResponse,
    };
