// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileImageRequest _$UpdateProfileImageRequestFromJson(Map<String, dynamic> json) =>
    UpdateProfileImageRequest(
      image: json['Image'] as String? ?? "",
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateProfileImageRequestToJson(UpdateProfileImageRequest instance) =>
    <String, dynamic>{
      'Image': instance.image,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
