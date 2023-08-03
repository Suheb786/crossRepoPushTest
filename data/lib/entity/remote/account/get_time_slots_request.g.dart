// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_time_slots_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTimeSlotsRequest _$GetTimeSlotsRequestFromJson(Map<String, dynamic> json) => GetTimeSlotsRequest(
      gender: json['gender'] as String? ?? "",
      baseData: json['BaseClass'] as Map<String, dynamic>,
      callDate: json['callDate'] as String?,
      dateToSend: json['dateToSend'] as int?,
    );

Map<String, dynamic> _$GetTimeSlotsRequestToJson(GetTimeSlotsRequest instance) => <String, dynamic>{
      'callDate': instance.callDate,
      'dateToSend': instance.dateToSend,
      'gender': instance.gender,
      'BaseClass': instance.baseData,
    };
