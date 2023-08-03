// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_version_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVersionUpdateRequest _$CheckVersionUpdateRequestFromJson(Map<String, dynamic> json) =>
    CheckVersionUpdateRequest(
      uniqueId: json['UniqueId'] as String?,
      platform: json['Platform'] as String?,
      clear: json['Clear'] as String? ?? "true",
      parentVersion: json['ParentVersion'] as String?,
      version: json['Version'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CheckVersionUpdateRequestToJson(CheckVersionUpdateRequest instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'Platform': instance.platform,
      'Clear': instance.clear,
      'ParentVersion': instance.parentVersion,
      'Version': instance.version,
      'baseClass': instance.baseData,
    };
