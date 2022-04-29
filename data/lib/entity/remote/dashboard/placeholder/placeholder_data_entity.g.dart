// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeholder_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceholderDataEntity _$PlaceholderDataEntityFromJson(
    Map<String, dynamic> json) {
  return PlaceholderDataEntity(
    placeholderId: json['placeholderId'] as int?,
    locationName: json['locationName'] as String?,
    status: json['status'] as bool?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$PlaceholderDataEntityToJson(
        PlaceholderDataEntity instance) =>
    <String, dynamic>{
      'placeholderId': instance.placeholderId,
      'locationName': instance.locationName,
      'status': instance.status,
      'image': instance.image,
    };
