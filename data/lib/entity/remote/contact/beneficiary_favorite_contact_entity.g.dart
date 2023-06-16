// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_favorite_contact_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryFavoriteContactEntity _$BeneficiaryFavoriteContactEntityFromJson(
        Map<String, dynamic> json) =>
    BeneficiaryFavoriteContactEntity(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      type: json['type'] as String?,
      nickName: json['nickName'] as String?,
      alias: json['alias'] as String?,
      fullName: json['fullName'] as String?,
      accountNo: json['accountNo'] as String?,
      swiftCode: json['swiftCode'] as String?,
      sortCode: json['sortCode'] as String?,
      bankCode: json['bankCode'] as String?,
      countryCode: json['countryCode'] as String?,
      isVerified: json['isVerified'] as bool?,
      createTime: json['createTime'] as String?,
      createTerminal: json['createTerminal'] as String?,
      bankName: json['bankName'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      addressLine3: json['addressLine3'] as String?,
      addressLine4: json['addressLine4'] as String?,
      beneficiaryAccountCurrency: json['beneficiaryAccountCurrency'] as String?,
      routingNo: json['routingNo'] as String?,
      ifscCode: json['ifscCode'] as String?,
      beneficiaryIban: json['beneficiaryIban'] as String?,
      beneficiaryType: json['beneficiaryType'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      image: json['image'] as String?,
      purpose: json['purpose'] as String?,
      purposeDetails: json['purposeDetails'] as String?,
      purposeParent: json['purposeParent'] as String?,
      purposeParentDetails: json['purposeParentDetails'] as String?,
      limit: json['limit'] as num?,
      purposeType: json['purposeType'] as String?,
      detCustomerType: json['detCustomerType'] as String?,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$BeneficiaryFavoriteContactEntityToJson(
        BeneficiaryFavoriteContactEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'nickName': instance.nickName,
      'alias': instance.alias,
      'fullName': instance.fullName,
      'accountNo': instance.accountNo,
      'swiftCode': instance.swiftCode,
      'sortCode': instance.sortCode,
      'bankCode': instance.bankCode,
      'countryCode': instance.countryCode,
      'isVerified': instance.isVerified,
      'createTime': instance.createTime,
      'createTerminal': instance.createTerminal,
      'bankName': instance.bankName,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressLine3': instance.addressLine3,
      'addressLine4': instance.addressLine4,
      'beneficiaryAccountCurrency': instance.beneficiaryAccountCurrency,
      'routingNo': instance.routingNo,
      'ifscCode': instance.ifscCode,
      'beneficiaryIban': instance.beneficiaryIban,
      'beneficiaryType': instance.beneficiaryType,
      'mobileNumber': instance.mobileNumber,
      'image': instance.image,
      'purpose': instance.purpose,
      'purposeDetails': instance.purposeDetails,
      'purposeParent': instance.purposeParent,
      'purposeParentDetails': instance.purposeParentDetails,
      'limit': instance.limit,
      'purposeType': instance.purposeType,
      'detCustomerType': instance.detCustomerType,
      'isFavorite': instance.isFavorite,
    };
