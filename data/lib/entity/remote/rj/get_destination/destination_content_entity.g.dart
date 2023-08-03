// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationContentEntity _$DestinationContentEntityFromJson(Map<String, dynamic> json) =>
    DestinationContentEntity(
      destinationList: (json['content'] as List<dynamic>?)
          ?.map((e) => DestinationEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DestinationContentEntityToJson(DestinationContentEntity instance) => <String, dynamic>{
      'content': instance.destinationList,
    };
