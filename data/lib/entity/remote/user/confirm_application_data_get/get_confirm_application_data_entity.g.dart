// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_confirm_application_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfirmApplicationDataEntity _$GetConfirmApplicationDataEntityFromJson(
    Map<String, dynamic> json) {
  return GetConfirmApplicationDataEntity(
    data: json['data'] == null
        ? null
        : GetConfirmApplicationDataContentEntity.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetConfirmApplicationDataEntityToJson(
        GetConfirmApplicationDataEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
