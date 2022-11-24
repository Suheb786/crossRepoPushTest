// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDataResponseEntity _$DashboardDataResponseEntityFromJson(Map<String, dynamic> json) {
  return DashboardDataResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DashboardDataResponseEntityToJson(DashboardDataResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
