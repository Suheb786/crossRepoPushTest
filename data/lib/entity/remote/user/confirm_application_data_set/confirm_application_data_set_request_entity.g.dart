// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_application_data_set_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmApplicationDataSetRequestEntity
    _$ConfirmApplicationDataSetRequestEntityFromJson(
        Map<String, dynamic> json) {
  return ConfirmApplicationDataSetRequestEntity(
    reviewDocumentResponse: json['ReviewDocumentResponse'] == null
        ? null
        : ReviewApplicationDataEntity.fromJson(
            json['ReviewDocumentResponse'] as Map<String, dynamic>),
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$ConfirmApplicationDataSetRequestEntityToJson(
        ConfirmApplicationDataSetRequestEntity instance) =>
    <String, dynamic>{
      'ReviewDocumentResponse': instance.reviewDocumentResponse,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
