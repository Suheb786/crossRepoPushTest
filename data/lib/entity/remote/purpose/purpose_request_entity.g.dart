// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeRequestEntity _$PurposeRequestEntityFromJson(Map<String, dynamic> json) {
  return PurposeRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    toAmount: json['ToAmount'] as String?,
    transferType: json['TransferType'] as String?,
    getToken: json['getToken'] as bool,
  );
}

Map<String, dynamic> _$PurposeRequestEntityToJson(
        PurposeRequestEntity instance) =>
    <String, dynamic>{
      'ToAmount': instance.toAmount,
      'TransferType': instance.transferType,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
