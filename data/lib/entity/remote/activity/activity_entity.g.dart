// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityEntity _$ActivityEntityFromJson(Map<String, dynamic> json) =>
    ActivityEntity(
      headingAr: json['headingAr'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      description: json['description'] as String?,
      heading: json['heading'] as String?,
    );

Map<String, dynamic> _$ActivityEntityToJson(ActivityEntity instance) =>
    <String, dynamic>{
      'heading': instance.heading,
      'description': instance.description,
      'headingAr': instance.headingAr,
      'descriptionAr': instance.descriptionAr,
    };
