// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_customer_schedule_time_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCustomerScheduleTimeRequestEntity
    _$SaveCustomerScheduleTimeRequestEntityFromJson(Map<String, dynamic> json) {
  return SaveCustomerScheduleTimeRequestEntity(
    scheduleDate: json['ScheduleDate'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
    scheduleTime: json['ScheduleTime'] as String?,
  );
}

Map<String, dynamic> _$SaveCustomerScheduleTimeRequestEntityToJson(
        SaveCustomerScheduleTimeRequestEntity instance) =>
    <String, dynamic>{
      'ScheduleTime': instance.scheduleTime,
      'ScheduleDate': instance.scheduleDate,
      'baseClass': instance.baseData,
    };
