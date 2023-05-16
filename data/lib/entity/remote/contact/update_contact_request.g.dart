// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateContactRequest _$UpdateContactRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateContactRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      nickName: json['NickName'] as String?,
      fullName: json['FullName'] as String?,
      emailAddress: json['EmailAddress'] as String?,
      userId: json['UserId'] as String?,
      identifier: json['Identifier'] as String?,
      isFromMobile: json['IsFromMobile'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateContactRequestToJson(
        UpdateContactRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'NickName': instance.nickName,
      'FullName': instance.fullName,
      'EmailAddress': instance.emailAddress,
      'UserId': instance.userId,
      'Identifier': instance.identifier,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
