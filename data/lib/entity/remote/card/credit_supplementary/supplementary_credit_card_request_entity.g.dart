// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardRequestEntity
    _$SupplementaryCreditCardRequestEntityFromJson(Map<String, dynamic> json) =>
        SupplementaryCreditCardRequestEntity(
          primaryCardId: json['PrimaryCardId'] as String?,
          type: json['Type'] as String?,
          limit: json['Limit'] as num?,
          fullName: json['FullName'] as String?,
          nationality: json['Nationality'] as String?,
          gender: json['Gender'] as String?,
          firstName: json['FirstName'] as String?,
          dob: json['DOB'] as String?,
          nickName: json['NickName'] as String?,
          backCardImage: json['BackCardImage'] as String?,
          documentCode: json['DocumentCode'] as String?,
          documentNumber: json['DocumentNumber'] as String?,
          doe: json['DOE'] as String?,
          doi: json['DOI'],
          familyName: json['FamilyName'] as String?,
          frontCardImage: json['FrontCardImage'] as String?,
          idNumber: json['IdNumber'] as String?,
          issuer: json['Issuer'] as String?,
          middleName: json['MiddleName'] as String?,
          mrtDraw: json['MrtDraw'] as String?,
          optionalData1: json['OptionalData1'] as String?,
          optionalData2: json['OptionalData2'] as String?,
          relationship: json['Relationship'] as String?,
          sameLimit: json['SameLimit'] as bool?,
          getToken: json['GetToken'] as bool? ?? false,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$SupplementaryCreditCardRequestEntityToJson(
        SupplementaryCreditCardRequestEntity instance) =>
    <String, dynamic>{
      'PrimaryCardId': instance.primaryCardId,
      'Relationship': instance.relationship,
      'DOI': instance.doi,
      'Type': instance.type,
      'FullName': instance.fullName,
      'FirstName': instance.firstName,
      'MiddleName': instance.middleName,
      'FamilyName': instance.familyName,
      'IdNumber': instance.idNumber,
      'DOB': instance.dob,
      'DOE': instance.doe,
      'Gender': instance.gender,
      'DocumentCode': instance.documentCode,
      'DocumentNumber': instance.documentNumber,
      'Issuer': instance.issuer,
      'Nationality': instance.nationality,
      'OptionalData1': instance.optionalData1,
      'OptionalData2': instance.optionalData2,
      'MrtDraw': instance.mrtDraw,
      'FrontCardImage': instance.frontCardImage,
      'BackCardImage': instance.backCardImage,
      'NickName': instance.nickName,
      'SameLimit': instance.sameLimit,
      'Limit': instance.limit,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
