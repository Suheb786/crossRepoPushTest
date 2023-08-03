// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeRequestEntity _$PurposeRequestEntityFromJson(Map<String, dynamic> json) => PurposeRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      toAccount: json['ToAccount'] as String?,
      transferType: json['TransferType'] as String?,
      getToken: json['getToken'] as bool? ?? true,
      type: json['Type'] as String?,
      detCustomerType: json['DetCustomerType'] as String?,
    );

Map<String, dynamic> _$PurposeRequestEntityToJson(PurposeRequestEntity instance) => <String, dynamic>{
      'ToAccount': instance.toAccount,
      'TransferType': instance.transferType,
      'Type': instance.type,
      'DetCustomerType': instance.detCustomerType,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
