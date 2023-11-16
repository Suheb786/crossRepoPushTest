// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_login_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndroidLoginContentEntity _$AndroidLoginContentEntityFromJson(
        Map<String, dynamic> json) =>
    AndroidLoginContentEntity(
      applepay: json['applepay'] as bool?,
      journeyId: json['journeyId'] as String?,
      journeyRefId: json['journeyRefId'] as String?,
      rimNo: json['rimNo'] as String?,
    );

Map<String, dynamic> _$AndroidLoginContentEntityToJson(
        AndroidLoginContentEntity instance) =>
    <String, dynamic>{
      'applepay': instance.applepay,
      'journeyRefId': instance.journeyRefId,
      'journeyId': instance.journeyId,
      'rimNo': instance.rimNo,
    };
