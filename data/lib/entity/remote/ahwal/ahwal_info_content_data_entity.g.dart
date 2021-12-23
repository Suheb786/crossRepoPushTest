// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ahwal_info_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AhwalInfoContentDataEntity _$AhwalInfoContentDataEntityFromJson(
    Map<String, dynamic> json) {
  return AhwalInfoContentDataEntity(
    ahwalImageStatus: json['ahwalImageStatus'] as String?,
    ahwalInfo: json['ahwalinfo'] == null
        ? null
        : AhwalInfoEntity.fromJson(json['ahwalinfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AhwalInfoContentDataEntityToJson(
    AhwalInfoContentDataEntity instance) =>
    <String, dynamic>{
      'ahwalImageStatus': instance.ahwalImageStatus,
      'ahwalinfo': instance.ahwalInfo,
    };
