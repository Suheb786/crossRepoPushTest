// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_cliq_id_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditCliqEntity _$EditCliqEntityFromJson(Map<String, dynamic> json) =>
    EditCliqEntity(
      json['message'] as String? ?? '',
      json['isSuccess'] as bool? ?? false,
    );

Map<String, dynamic> _$EditCliqEntityToJson(EditCliqEntity instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
    };
