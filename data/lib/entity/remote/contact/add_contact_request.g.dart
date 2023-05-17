// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContactRequest _$AddContactRequestFromJson(Map<String, dynamic> json) =>
    AddContactRequest(
      nickName: json['NickName'] as String?,
      fullName: json['FullName'] as String?,
      emailAddress: json['EmailAddress'] as String?,
      avatarImg: json['AvatarImg'] as String?,
      isFav: json['IsFav'] as bool?,
      userId: json['UserId'] as String?,
      identifier: json['Identifier'] as String?,
      isFromMobile: json['IsFromMobile'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddContactRequestToJson(AddContactRequest instance) =>
    <String, dynamic>{
      'NickName': instance.nickName,
      'FullName': instance.fullName,
      'EmailAddress': instance.emailAddress,
      'AvatarImg': instance.avatarImg,
      'IsFav': instance.isFav,
      'UserId': instance.userId,
      'Identifier': instance.identifier,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
