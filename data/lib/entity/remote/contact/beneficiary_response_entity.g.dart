// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryResponseEntity _$BeneficiaryResponseEntityFromJson(
    Map<String, dynamic> json) {
  return BeneficiaryResponseEntity(
    beneficiaryList: (json['beneficiaryList'] as List<dynamic>?)
        ?.map((e) => BeneficiaryEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BeneficiaryResponseEntityToJson(
        BeneficiaryResponseEntity instance) =>
    <String, dynamic>{
      'beneficiaryList': instance.beneficiaryList,
    };
