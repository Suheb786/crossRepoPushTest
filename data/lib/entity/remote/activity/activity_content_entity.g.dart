// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityContentEntity _$ActivityContentEntityFromJson(
        Map<String, dynamic> json) =>
    ActivityContentEntity(
      activityContent: (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivityContentEntityToJson(
        ActivityContentEntity instance) =>
    <String, dynamic>{
      'activities': instance.activityContent,
    };
