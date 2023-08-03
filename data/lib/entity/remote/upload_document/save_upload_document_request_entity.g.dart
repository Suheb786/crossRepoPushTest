// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_upload_document_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveUploadDocumentRequestEntity _$SaveUploadDocumentRequestEntityFromJson(
        Map<String, dynamic> json) =>
    SaveUploadDocumentRequestEntity(
      proofOfAddressId: json['ProofOfAddressId'] as String?,
      proofOfIncomeId: json['ProofOfIncomeId'] as String?,
      proofOfNationalityId: json['ProofOfNationalityId'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SaveUploadDocumentRequestEntityToJson(
        SaveUploadDocumentRequestEntity instance) =>
    <String, dynamic>{
      'ProofOfIncomeId': instance.proofOfIncomeId,
      'ProofOfAddressId': instance.proofOfAddressId,
      'ProofOfNationalityId': instance.proofOfNationalityId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
