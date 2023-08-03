// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_existing_call_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckExistingCallStatusEntity _$CheckExistingCallStatusEntityFromJson(
        Map<String, dynamic> json) =>
    CheckExistingCallStatusEntity(
      isExist: json['isExist'] as bool?,
      isExpire: json['isExpire'] as bool?,
      scheduledDate: json['scheduledDate'] as String?,
      scheduledTime: json['scheduledTime'] as String?,
    );

Map<String, dynamic> _$CheckExistingCallStatusEntityToJson(
        CheckExistingCallStatusEntity instance) =>
    <String, dynamic>{
      'isExist': instance.isExist,
      'isExpire': instance.isExpire,
      'scheduledDate': instance.scheduledDate,
      'scheduledTime': instance.scheduledTime,
    };
