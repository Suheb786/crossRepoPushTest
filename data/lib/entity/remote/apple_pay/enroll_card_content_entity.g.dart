// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enroll_card_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollCardContentEntity _$EnrollCardContentEntityFromJson(Map<String, dynamic> json) =>
    EnrollCardContentEntity(
      cardId: json['cardId'] as String?,
      enrollmentData: json['enrollmentData'] as String?,
    );

Map<String, dynamic> _$EnrollCardContentEntityToJson(EnrollCardContentEntity instance) => <String, dynamic>{
      'enrollmentData': instance.enrollmentData,
      'cardId': instance.cardId,
    };
