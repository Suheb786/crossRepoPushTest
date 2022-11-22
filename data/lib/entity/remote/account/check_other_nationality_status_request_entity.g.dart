// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_other_nationality_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOtherNationalityStatusRequestEntity _$CheckOtherNationalityStatusRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CheckOtherNationalityStatusRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CheckOtherNationalityStatusRequestEntityToJson(
        CheckOtherNationalityStatusRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
