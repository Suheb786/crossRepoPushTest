// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trip_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripContentDataEntity _$GetTripContentDataEntityFromJson(
        Map<String, dynamic> json) =>
    GetTripContentDataEntity(
      content: json['content'] == null
          ? null
          : GetTripContentEntity.fromJson(
              json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTripContentDataEntityToJson(
        GetTripContentDataEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
