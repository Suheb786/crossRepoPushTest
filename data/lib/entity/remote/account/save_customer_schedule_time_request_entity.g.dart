// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_customer_schedule_time_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCustomerScheduleTimeRequestEntity
    _$SaveCustomerScheduleTimeRequestEntityFromJson(
            Map<String, dynamic> json) =>
        SaveCustomerScheduleTimeRequestEntity(
          callDate: json['callDate'] as String?,
          gender: json['gender'] as String? ?? "",
          startTime: json['startTime'] as String?,
          dateToSend: json['dateToSend'] as int?,
          productId: json['productId'] as int? ?? 1,
          getToken: json['getToken'] as bool? ?? true,
          baseData: json['baseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$SaveCustomerScheduleTimeRequestEntityToJson(
        SaveCustomerScheduleTimeRequestEntity instance) =>
    <String, dynamic>{
      'callDate': instance.callDate,
      'gender': instance.gender,
      'startTime': instance.startTime,
      'dateToSend': instance.dateToSend,
      'productId': instance.productId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
