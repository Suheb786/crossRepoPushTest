// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_gender_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckGenderStatusEntity _$CheckGenderStatusEntityFromJson(
        Map<String, dynamic> json) =>
    CheckGenderStatusEntity(
      isMaleAvailable: json['maleAvailable'] as bool? ?? false,
      isFemaleAvailable: json['femaleAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckGenderStatusEntityToJson(
        CheckGenderStatusEntity instance) =>
    <String, dynamic>{
      'maleAvailable': instance.isMaleAvailable,
      'femaleAvailable': instance.isFemaleAvailable,
    };
