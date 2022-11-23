// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_confirm_application_data_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfirmApplicationDataContentEntity _$GetConfirmApplicationDataContentEntityFromJson(
    Map<String, dynamic> json) {
  return GetConfirmApplicationDataContentEntity(
    profileStatus: json['profileStatus'] == null
        ? null
        : ProfileStatusEntity.fromJson(json['profileStatus'] as Map<String, dynamic>),
    countryResidence: json['countryResidence'] == null
        ? null
        : CountryResidenceEntity.fromJson(json['countryResidence'] as Map<String, dynamic>),
    jobDetail: json['jobDetail'] == null
        ? null
        : JobDetailEntity.fromJson(json['jobDetail'] as Map<String, dynamic>),
    accountPurpose: json['accountPurpose'] == null
        ? null
        : AccountPurposeEntity.fromJson(json['accountPurpose'] as Map<String, dynamic>),
    fatcaCrs:
        json['fatcaCrs'] == null ? null : FatcaCrsEntity.fromJson(json['fatcaCrs'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetConfirmApplicationDataContentEntityToJson(
        GetConfirmApplicationDataContentEntity instance) =>
    <String, dynamic>{
      'profileStatus': instance.profileStatus,
      'countryResidence': instance.countryResidence,
      'jobDetail': instance.jobDetail,
      'accountPurpose': instance.accountPurpose,
      'fatcaCrs': instance.fatcaCrs,
    };
