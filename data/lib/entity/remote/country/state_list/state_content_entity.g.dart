// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateContentEntity _$StateContentEntityFromJson(Map<String, dynamic> json) {
  return StateContentEntity(
    getStates: (json['getStates'] as List<dynamic>?)
        ?.map((e) => StateCityDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StateContentEntityToJson(StateContentEntity instance) => <String, dynamic>{
      'getStates': instance.getStates,
    };
