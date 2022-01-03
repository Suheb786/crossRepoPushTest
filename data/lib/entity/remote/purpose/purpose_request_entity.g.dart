// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeRequestEntity _$PurposeRequestEntityFromJson(Map<String, dynamic> json) {
  return PurposeRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    toAccount: json['ToAccount'] as String?,
    transferType: json['TransferType'] as String?,
    getToken: json['getToken'] as bool,
  );
}

Map<String, dynamic> _$PurposeRequestEntityToJson(
        PurposeRequestEntity instance) =>
    <String, dynamic>{
      'ToAccount': instance.toAccount,
      'TransferType': instance.transferType,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
