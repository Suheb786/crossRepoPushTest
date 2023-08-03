// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_existing_video_call_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckExistingVideoCallRequest _$CheckExistingVideoCallRequestFromJson(Map<String, dynamic> json) =>
    CheckExistingVideoCallRequest(
      productId: json['productId'] as int? ?? 1,
      dateToSend: json['dateToSend'] as int?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CheckExistingVideoCallRequestToJson(CheckExistingVideoCallRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'dateToSend': instance.dateToSend,
      'BaseClass': instance.baseData,
    };
