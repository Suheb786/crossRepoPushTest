// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_journey_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateJourneyEntity _$UpdateJourneyEntityFromJson(Map<String, dynamic> json) =>
    UpdateJourneyEntity(
      selfieStatus: json['selfieStatus'] as bool?,
      selfieTitle: json['selfieTitle'] as String?,
      selfieDetail: json['selfieDetail'] as String?,
      documentStatus: json['documentStatus'] as bool?,
      documentTitle: json['documentTitle'] as String?,
      documentDetail: json['documentDetail'] as String?,
    );

Map<String, dynamic> _$UpdateJourneyEntityToJson(
        UpdateJourneyEntity instance) =>
    <String, dynamic>{
      'selfieStatus': instance.selfieStatus,
      'selfieTitle': instance.selfieTitle,
      'selfieDetail': instance.selfieDetail,
      'documentStatus': instance.documentStatus,
      'documentTitle': instance.documentTitle,
      'documentDetail': instance.documentDetail,
    };
