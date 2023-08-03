// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryRequest _$AddBeneficiaryRequestFromJson(Map<String, dynamic> json) => AddBeneficiaryRequest(
      nickName: json['NickName'] as String?,
      fullName: json['FullName'] as String?,
      avatarImg: json['AvatarImg'] as String?,
      beneficiaryType: json['BeneficiaryType'] as String?,
      isFavourite: json['IsFavourite'] as bool?,
      userId: json['UserId'] as String?,
      identifier: json['Identifier'] as String?,
      isFromMobile: json['IsFromMobile'] as bool?,
      detCustomerType: json['DetCustomerType'] as String?,
      alias: json['Alias'] as String?,
      addressLine1: json['AddressLine1'] as String?,
      addressLine2: json['AddressLine2'] as String?,
      addressLine3: json['AddressLine3'] as String?,
      addressLine4: json['AddressLine4'] as String?,
      limit: json['Limit'] as int?,
      IFSCCode: json['IFSCCode'] as String?,
      routingNo: json['RoutingNo'] as String?,
      sortCode: json['SortCode'] as String?,
      purposeType: json['PurposeType'] as String?,
      purpose: json['Purpose'] as String?,
      purposeDetails: json['PurposeDetails'] as String?,
      purposeParent: json['PurposeParent'] as String?,
      purposeParentDetails: json['PurposeParentDetails'] as String?,
      otpCode: json['OtpCode'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddBeneficiaryRequestToJson(AddBeneficiaryRequest instance) => <String, dynamic>{
      'NickName': instance.nickName,
      'FullName': instance.fullName,
      'AvatarImg': instance.avatarImg,
      'BeneficiaryType': instance.beneficiaryType,
      'IsFavourite': instance.isFavourite,
      'UserId': instance.userId,
      'Identifier': instance.identifier,
      'IsFromMobile': instance.isFromMobile,
      'DetCustomerType': instance.detCustomerType,
      'Alias': instance.alias,
      'AddressLine1': instance.addressLine1,
      'AddressLine2': instance.addressLine2,
      'AddressLine3': instance.addressLine3,
      'AddressLine4': instance.addressLine4,
      'Limit': instance.limit,
      'IFSCCode': instance.IFSCCode,
      'RoutingNo': instance.routingNo,
      'SortCode': instance.sortCode,
      'PurposeType': instance.purposeType,
      'Purpose': instance.purpose,
      'PurposeDetails': instance.purposeDetails,
      'PurposeParent': instance.purposeParent,
      'PurposeParentDetails': instance.purposeParentDetails,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
