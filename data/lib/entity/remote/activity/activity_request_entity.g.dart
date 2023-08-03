// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRequestEntity _$ActivityRequestEntityFromJson(Map<String, dynamic> json) => ActivityRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      noOfDays: json['NoOfDays'] as num?,
      isDebit: json['IsDebit'] as String?,
    );

Map<String, dynamic> _$ActivityRequestEntityToJson(ActivityRequestEntity instance) => <String, dynamic>{
      'NoOfDays': instance.noOfDays,
      'IsDebit': instance.isDebit,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
