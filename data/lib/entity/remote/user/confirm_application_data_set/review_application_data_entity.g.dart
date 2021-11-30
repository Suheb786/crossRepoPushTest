// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_application_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewApplicationDataEntity _$ReviewApplicationDataEntityFromJson(
    Map<String, dynamic> json) {
  return ReviewApplicationDataEntity(
    countryResidence: json['countryResidence'] == null
        ? null
        : CountryResidenceEntity.fromJson(
            json['countryResidence'] as Map<String, dynamic>),
    accountPurpose: json['accountPurpose'] == null
        ? null
        : AccountPurposeEntity.fromJson(
            json['accountPurpose'] as Map<String, dynamic>),
    fatcaCrs: json['fatcaCrs'] == null
        ? null
        : FatcaCrsEntity.fromJson(json['fatcaCrs'] as Map<String, dynamic>),
    profileStatus: json['profileStatus'] == null
        ? null
        : ProfileStatusEntity.fromJson(
            json['profileStatus'] as Map<String, dynamic>),
    jobDetail: json['jobDetail'] == null
        ? null
        : JobDetailEntity.fromJson(json['jobDetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReviewApplicationDataEntityToJson(
        ReviewApplicationDataEntity instance) =>
    <String, dynamic>{
      'countryResidence': instance.countryResidence,
      'profileStatus': instance.profileStatus,
      'jobDetail': instance.jobDetail,
      'accountPurpose': instance.accountPurpose,
      'fatcaCrs': instance.fatcaCrs,
    };
