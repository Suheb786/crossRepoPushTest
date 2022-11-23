// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityContentEntity _$CityContentEntityFromJson(Map<String, dynamic> json) {
  return CityContentEntity(
    getCities: (json['getCities'] as List<dynamic>?)
        ?.map((e) => StateCityDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CityContentEntityToJson(CityContentEntity instance) => <String, dynamic>{
      'getCities': instance.getCities,
    };
