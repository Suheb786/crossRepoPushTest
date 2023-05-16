// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteContactRequest _$DeleteContactRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteContactRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      nickName: json['NickName'] as String?,
      fullName: json['FullName'] as String?,
      emailAddress: json['EmailAddress'] as String?,
      avatarImg: json['AvatarImg'] as String?,
      isFav: json['IsFav'] as bool?,
      userId: json['UserId'] as String?,
      isFromMobile: json['IsFromMobile'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeleteContactRequestToJson(
        DeleteContactRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'NickName': instance.nickName,
      'FullName': instance.fullName,
      'EmailAddress': instance.emailAddress,
      'AvatarImg': instance.avatarImg,
      'IsFav': instance.isFav,
      'UserId': instance.userId,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
