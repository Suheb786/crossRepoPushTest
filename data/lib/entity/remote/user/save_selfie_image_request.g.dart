// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_selfie_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveSelfieImageRequest _$SaveSelfieImageRequestFromJson(Map<String, dynamic> json) => SaveSelfieImageRequest(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      selfieImage: json['SelfeeImage'] as String?,
    );

Map<String, dynamic> _$SaveSelfieImageRequestToJson(SaveSelfieImageRequest instance) => <String, dynamic>{
      'GetToken': instance.getToken,
      'SelfeeImage': instance.selfieImage,
      'baseClass': instance.baseData,
    };
