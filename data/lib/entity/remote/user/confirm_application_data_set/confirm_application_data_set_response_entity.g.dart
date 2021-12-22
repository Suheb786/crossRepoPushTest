// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_application_data_set_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmApplicationDataSetResponseEntity
_$ConfirmApplicationDataSetResponseEntityFromJson(Map<String, dynamic> json) {
  return ConfirmApplicationDataSetResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConfirmApplicationDataSetResponseEntityToJson(
    ConfirmApplicationDataSetResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
