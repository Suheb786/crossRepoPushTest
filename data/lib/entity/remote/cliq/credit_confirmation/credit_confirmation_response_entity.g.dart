// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_confirmation_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditConfirmationResponseEntity _$CreditConfirmationResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CreditConfirmationResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditConfirmationResponseEntityToJson(
        CreditConfirmationResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
