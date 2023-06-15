// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_avatar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAvatarRequest _$UpdateAvatarRequestFromJson(Map<String, dynamic> json) =>
    UpdateAvatarRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      userId: json['UserId'] as String? ?? '',
      image: json['BeneImage'] as String?,
      beneType: json['BeneType'] as String?,
      nickName: json['Nickname'] as String? ?? '',
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateAvatarRequestToJson(
        UpdateAvatarRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'UserId': instance.userId,
      'BeneImage': instance.image,
      'IsFromMobile': instance.isFromMobile,
      'BeneType': instance.beneType,
      'Nickname': instance.nickName,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
