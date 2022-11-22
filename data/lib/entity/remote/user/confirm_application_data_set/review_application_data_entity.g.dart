// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_application_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewApplicationDataEntity _$ReviewApplicationDataEntityFromJson(Map<String, dynamic> json) {
  return ReviewApplicationDataEntity(
    countryResidence: json['countryResidence'] as Map<String, dynamic>?,
    accountPurpose: json['accountPurpose'] as Map<String, dynamic>?,
    fatcaCrs: json['fatcaCrs'] as Map<String, dynamic>?,
    profileStatus: json['profileStatus'] as Map<String, dynamic>?,
    jobDetail: json['jobDetail'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$ReviewApplicationDataEntityToJson(ReviewApplicationDataEntity instance) =>
    <String, dynamic>{
      'countryResidence': instance.countryResidence,
      'profileStatus': instance.profileStatus,
      'jobDetail': instance.jobDetail,
      'accountPurpose': instance.accountPurpose,
      'fatcaCrs': instance.fatcaCrs,
    };
