// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_send_money_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckSendMoneyResponseEntity _$CheckSendMoneyResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CheckSendMoneyResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckSendMoneyResponseEntityToJson(
        CheckSendMoneyResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
