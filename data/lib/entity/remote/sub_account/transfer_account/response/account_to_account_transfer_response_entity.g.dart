// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_to_account_transfer_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountToAccountTransferResponseEntity
    _$AccountToAccountTransferResponseEntityFromJson(
            Map<String, dynamic> json) =>
        AccountToAccountTransferResponseEntity(
          json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AccountToAccountTransferResponseEntityToJson(
        AccountToAccountTransferResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
