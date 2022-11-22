// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_beneficiary_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadBeneficiaryImageRequest _$UploadBeneficiaryImageRequestFromJson(Map<String, dynamic> json) {
  return UploadBeneficiaryImageRequest(
    beneficiaryID: json['BeneficiaryID'] as String,
    image: json['Image'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$UploadBeneficiaryImageRequestToJson(UploadBeneficiaryImageRequest instance) =>
    <String, dynamic>{
      'BeneficiaryID': instance.beneficiaryID,
      'Image': instance.image,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
