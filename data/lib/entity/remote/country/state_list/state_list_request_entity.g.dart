// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_list_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateListRequestEntity _$StateListRequestEntityFromJson(Map<String, dynamic> json) => StateListRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      isoCode: json['IsoCode'] as String? ?? "",
    );

Map<String, dynamic> _$StateListRequestEntityToJson(StateListRequestEntity instance) => <String, dynamic>{
      'IsoCode': instance.isoCode,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
