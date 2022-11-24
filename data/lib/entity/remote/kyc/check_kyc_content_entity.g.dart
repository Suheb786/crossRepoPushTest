// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_kyc_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckKycContentEntity _$CheckKycContentEntityFromJson(Map<String, dynamic> json) {
  return CheckKycContentEntity(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => CheckKycDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CheckKycContentEntityToJson(CheckKycContentEntity instance) => <String, dynamic>{
      'data': instance.data,
    };
