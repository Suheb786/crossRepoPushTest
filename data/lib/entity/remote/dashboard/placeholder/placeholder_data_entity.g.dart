// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeholder_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceholderDataEntity _$PlaceholderDataEntityFromJson(
        Map<String, dynamic> json) =>
    PlaceholderDataEntity(
      placeholderId: json['placeholderId'] as int? ?? 0,
      locationName: json['locationName'] as String? ?? "",
      status: json['status'] as bool? ?? false,
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$PlaceholderDataEntityToJson(
        PlaceholderDataEntity instance) =>
    <String, dynamic>{
      'placeholderId': instance.placeholderId,
      'locationName': instance.locationName,
      'status': instance.status,
      'image': instance.image,
    };
