// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_application_data_get_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmApplicationDataGetRequestEntity _$ConfirmApplicationDataGetRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ConfirmApplicationDataGetRequestEntity(
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ConfirmApplicationDataGetRequestEntityToJson(
        ConfirmApplicationDataGetRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
