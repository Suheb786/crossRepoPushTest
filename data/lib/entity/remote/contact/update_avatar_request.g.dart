// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_avatar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAvatarRequest _$UpdateAvatarRequestFromJson(Map<String, dynamic> json) =>
    UpdateAvatarRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      avatarImg: json['AvatarImg'] as String?,
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateAvatarRequestToJson(
        UpdateAvatarRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'AvatarImg': instance.avatarImg,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
