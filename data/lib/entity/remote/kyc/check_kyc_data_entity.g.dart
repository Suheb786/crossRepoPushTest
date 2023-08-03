// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_kyc_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckKycDataEntity _$CheckKycDataEntityFromJson(Map<String, dynamic> json) =>
    CheckKycDataEntity(
      type: json['type'] as String?,
      status: json['status'] as bool?,
      error: json['error'] as String?,
      isOptioanl: json['isOptioanl'] as bool?,
    );

Map<String, dynamic> _$CheckKycDataEntityToJson(CheckKycDataEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
      'error': instance.error,
      'isOptioanl': instance.isOptioanl,
    };
