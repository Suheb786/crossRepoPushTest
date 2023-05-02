// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_stolen_cc_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportStolenCCRequestEntity _$ReportStolenCCRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ReportStolenCCRequestEntity(
      cardCode: json['CardCode'] as String? ?? "",
      panGenerationMode: json['PanGenerationMode'] as String? ?? "",
      replaceReason: json['ReplaceReason'] as String? ?? "",
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ReportStolenCCRequestEntityToJson(
        ReportStolenCCRequestEntity instance) =>
    <String, dynamic>{
      'CardCode': instance.cardCode,
      'PanGenerationMode': instance.panGenerationMode,
      'ReplaceReason': instance.replaceReason,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
