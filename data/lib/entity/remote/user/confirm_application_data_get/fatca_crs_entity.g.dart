// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatca_crs_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FatcaCrsEntity _$FatcaCrsEntityFromJson(Map<String, dynamic> json) =>
    FatcaCrsEntity(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      companyId: json['companyId'] as int?,
      productId: json['productId'] as int?,
      accountId: json['accountId'] as int?,
      response1: json['response1'] as bool?,
      response2: json['response2'] as bool?,
      response3: json['response3'] as bool?,
      response4: json['response4'] as bool?,
      response5: json['response5'] as bool?,
      relationshipWithPep: json['relationshipWithPEP'] as String?,
      personName: json['personName'] as String?,
      personRole: json['personRole'] as String?,
      namePerIncomeTaxReturn: json['namePerIncomeTaxReturn'],
      dob: json['dob'],
      citizenShipCountry: json['citizenShipCountry'],
      permanentResidenceAddress: json['permanentResidenceAddress'],
      country: json['country'],
      city: json['city'],
      state: json['state'],
      postCode: json['postCode'],
      differentMailingAddress: json['differentMailingAddress'],
      taxPayer: json['taxPayer'],
      usTaxIdNo: json['usTaxIdNo'],
      claimTaxTreatBenefits: json['claimTaxTreatBenefits'],
      beneficialOwnerResident: json['beneficialOwnerResident'],
      usTaxpayerIdNoOwner: json['usTaxpayerIdNoOwner'],
      typeOfIncome: json['typeOfIncome'],
      explanation: json['explanation'],
      businessName: json['businessName'],
      usAddress: json['usAddress'],
      accountNo: json['accountNo'],
      exemptPayeeCode: json['exemptPayeeCode'],
      socialSecurityNo: json['socialSecurityNo'],
      createBy: json['createBy'] as String?,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      createTerminal: json['createTerminal'] as String?,
      taxResidenceCountry: json['taxResidenceCountry'] as String?,
      deactivatedDate: json['deactivatedDate'],
      signatureId: json['signatureId'],
      isActive: json['isActive'] as bool? ?? false,
      relationshipWithPEPName: json['relationshipWithPEPName'] as String? ?? "",
      relationshipWithPEPNameAr: json['relationshipWithPEPNameAr'] as String?,
    );

Map<String, dynamic> _$FatcaCrsEntityToJson(FatcaCrsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'productId': instance.productId,
      'accountId': instance.accountId,
      'response1': instance.response1,
      'response2': instance.response2,
      'response3': instance.response3,
      'response4': instance.response4,
      'response5': instance.response5,
      'isActive': instance.isActive,
      'deactivatedDate': instance.deactivatedDate,
      'relationshipWithPEP': instance.relationshipWithPep,
      'relationshipWithPEPName': instance.relationshipWithPEPName,
      'relationshipWithPEPNameAr': instance.relationshipWithPEPNameAr,
      'personName': instance.personName,
      'personRole': instance.personRole,
      'signatureId': instance.signatureId,
      'namePerIncomeTaxReturn': instance.namePerIncomeTaxReturn,
      'dob': instance.dob,
      'citizenShipCountry': instance.citizenShipCountry,
      'permanentResidenceAddress': instance.permanentResidenceAddress,
      'country': instance.country,
      'city': instance.city,
      'state': instance.state,
      'postCode': instance.postCode,
      'differentMailingAddress': instance.differentMailingAddress,
      'taxPayer': instance.taxPayer,
      'usTaxIdNo': instance.usTaxIdNo,
      'claimTaxTreatBenefits': instance.claimTaxTreatBenefits,
      'beneficialOwnerResident': instance.beneficialOwnerResident,
      'usTaxpayerIdNoOwner': instance.usTaxpayerIdNoOwner,
      'typeOfIncome': instance.typeOfIncome,
      'explanation': instance.explanation,
      'businessName': instance.businessName,
      'usAddress': instance.usAddress,
      'accountNo': instance.accountNo,
      'exemptPayeeCode': instance.exemptPayeeCode,
      'socialSecurityNo': instance.socialSecurityNo,
      'createBy': instance.createBy,
      'createTime': instance.createTime?.toIso8601String(),
      'createTerminal': instance.createTerminal,
      'taxResidenceCountry': instance.taxResidenceCountry,
    };
