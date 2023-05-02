// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_customer_schedule_time_response_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCustomerScheduleTimeResponseDataEntity
    _$SaveCustomerScheduleTimeResponseDataEntityFromJson(
            Map<String, dynamic> json) =>
        SaveCustomerScheduleTimeResponseDataEntity(
          id: json['id'] as int?,
          customerId: json['customerId'] as String?,
          referenceNo: json['referenceNo'] as String?,
          scheduleDate: json['scheduleDate'] as String?,
          scheduleTime: json['scheduleTime'] as String?,
          createdOn: json['createdOn'] == null
              ? null
              : DateTime.parse(json['createdOn'] as String),
          isActive: json['isActive'] as bool?,
        );

Map<String, dynamic> _$SaveCustomerScheduleTimeResponseDataEntityToJson(
        SaveCustomerScheduleTimeResponseDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'referenceNo': instance.referenceNo,
      'scheduleDate': instance.scheduleDate,
      'scheduleTime': instance.scheduleTime,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
    };
