// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_customer_schedule_time_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCustomerScheduleTimeResponseEntity
_$SaveCustomerScheduleTimeResponseEntityFromJson(Map<String, dynamic> json) {
  return SaveCustomerScheduleTimeResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaveCustomerScheduleTimeResponseEntityToJson(
    SaveCustomerScheduleTimeResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
