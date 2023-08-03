// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_other_nationality_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOtherNationalityStatusResponseEntity
    _$CheckOtherNationalityStatusResponseEntityFromJson(
            Map<String, dynamic> json) =>
        CheckOtherNationalityStatusResponseEntity(
          json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CheckOtherNationalityStatusResponseEntityToJson(
        CheckOtherNationalityStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
