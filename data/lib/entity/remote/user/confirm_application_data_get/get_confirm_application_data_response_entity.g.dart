// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_confirm_application_data_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfirmApplicationDataResponseEntity _$GetConfirmApplicationDataResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetConfirmApplicationDataResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetConfirmApplicationDataResponseEntityToJson(
        GetConfirmApplicationDataResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
