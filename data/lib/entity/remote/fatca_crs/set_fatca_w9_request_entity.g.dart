// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_fatca_w9_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFatcaW9RequestEntity _$SetFatcaW9RequestEntityFromJson(
        Map<String, dynamic> json) =>
    SetFatcaW9RequestEntity(
      namePerIncomeTaxReturn: json['NamePerIncomeTaxReturn'] as String?,
      businessName: json['BusinessName'] as String?,
      uSAddress: json['USAddress'] as String?,
      countryCode: json['CountryCode'] as String?,
      stateId: json['State'] as String?,
      cityId: json['City'] as String?,
      postCode: json['PostCode'] as String?,
      accountNumberList: json['AccountNumberList'] as String?,
      exemptPayeeCode: json['ExemptPayeeCode'] as String?,
      exemptFromFatcaReportingCode:
          json['ExemptFromFatcaReportingCode'] as String?,
      isAdditionalRequester: json['AdditionalRequester'] as bool?,
      requesterName: json['RequesterName'] as String?,
      requesterUSAddress: json['RequesterUSAddress'] as String?,
      requesterCountryCode: json['RequesterCountryCode'] as String?,
      requesterState: json['RequesterState'] as String?,
      requesterCity: json['RequesterCity'] as String?,
      requesterPostCode: json['RequesterPostCode'] as String?,
      taxPayer: json['TaxPayer'] as String?,
      socialSecurityNumber: json['SocialSecurityNumber'] as String?,
      employerTIN: json['EmployerTIN'] as String?,
      signatureId: json['SignatureId'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['baseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SetFatcaW9RequestEntityToJson(
        SetFatcaW9RequestEntity instance) =>
    <String, dynamic>{
      'NamePerIncomeTaxReturn': instance.namePerIncomeTaxReturn,
      'BusinessName': instance.businessName,
      'USAddress': instance.uSAddress,
      'CountryCode': instance.countryCode,
      'State': instance.stateId,
      'City': instance.cityId,
      'PostCode': instance.postCode,
      'AccountNumberList': instance.accountNumberList,
      'ExemptPayeeCode': instance.exemptPayeeCode,
      'ExemptFromFatcaReportingCode': instance.exemptFromFatcaReportingCode,
      'AdditionalRequester': instance.isAdditionalRequester,
      'RequesterName': instance.requesterName,
      'RequesterUSAddress': instance.requesterUSAddress,
      'RequesterCountryCode': instance.requesterCountryCode,
      'RequesterState': instance.requesterState,
      'RequesterCity': instance.requesterCity,
      'RequesterPostCode': instance.requesterPostCode,
      'TaxPayer': instance.taxPayer,
      'SocialSecurityNumber': instance.socialSecurityNumber,
      'EmployerTIN': instance.employerTIN,
      'SignatureId': instance.signatureId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
