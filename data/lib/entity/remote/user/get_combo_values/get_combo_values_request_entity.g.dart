// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_combo_values_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetComboValuesRequestEntity _$GetComboValuesRequestEntityFromJson(Map<String, dynamic> json) =>
    GetComboValuesRequestEntity(
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetComboValuesRequestEntityToJson(GetComboValuesRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
