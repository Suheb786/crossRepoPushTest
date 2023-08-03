// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ahwal_detail_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AhwalDetailResponseEntity _$AhwalDetailResponseEntityFromJson(
        Map<String, dynamic> json) =>
    AhwalDetailResponseEntity(
      responseEntity: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AhwalDetailResponseEntityToJson(
        AhwalDetailResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
