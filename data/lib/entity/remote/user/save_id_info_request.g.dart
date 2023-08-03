// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_id_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveIdInfoRequest _$SaveIdInfoRequestFromJson(Map<String, dynamic> json) =>
    SaveIdInfoRequest(
      id: json['id'] as String?,
      type: json['type'] as String?,
      fullName: json['FullName'] as String?,
      firstName: json['FirstName'] as String?,
      middleName: json['MiddleName'] as String?,
      familyName: json['FamilyName'] as String?,
      idNumber: json['idNumber'] as String?,
      dob: json['dob'] as String?,
      doi: json['DOI'] as String?,
      nationality: json['nationality'] as String?,
      doe: json['doe'] as String?,
      gender: json['gender'] as String?,
      motherName: json['MotherFirstName'] as String?,
      documentCode: json['documentCode'] as String?,
      documentNumber: json['documentNumber'] as String?,
      issuer: json['issuer'] as String?,
      optionalData1: json['optionalData1'] as String?,
      optionalData2: json['optionalData2'] as String?,
      mrtDraw: json['mrtDraw'] as String?,
      frontCardImage: json['frontCardImage'] as String?,
      backCardImage: json['backCardImage'] as String?,
      personFaceImage: json['personFaceImage'] as String?,
      getToken: json['getToken'] as bool? ?? true,
      isimtfBlacklist: json['isimtfBlacklist'] as bool?,
      instanceID: json['instanceID'] as String?,
      scanPercentage: json['scanPercentage'] as num?,
      baseData: json['baseClass'] as Map<String, dynamic>,
      placeOfBirth: json['PlaceOfBirth'] as String?,
    );

Map<String, dynamic> _$SaveIdInfoRequestToJson(SaveIdInfoRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'FullName': instance.fullName,
      'FirstName': instance.firstName,
      'MiddleName': instance.middleName,
      'FamilyName': instance.familyName,
      'MotherFirstName': instance.motherName,
      'PlaceOfBirth': instance.placeOfBirth,
      'DOI': instance.doi,
      'idNumber': instance.idNumber,
      'dob': instance.dob,
      'nationality': instance.nationality,
      'doe': instance.doe,
      'gender': instance.gender,
      'documentCode': instance.documentCode,
      'documentNumber': instance.documentNumber,
      'issuer': instance.issuer,
      'optionalData1': instance.optionalData1,
      'optionalData2': instance.optionalData2,
      'mrtDraw': instance.mrtDraw,
      'frontCardImage': instance.frontCardImage,
      'backCardImage': instance.backCardImage,
      'personFaceImage': instance.personFaceImage,
      'getToken': instance.getToken,
      'isimtfBlacklist': instance.isimtfBlacklist,
      'instanceID': instance.instanceID,
      'scanPercentage': instance.scanPercentage,
      'baseClass': instance.baseData,
    };
