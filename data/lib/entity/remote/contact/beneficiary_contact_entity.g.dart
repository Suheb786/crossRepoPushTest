// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_contact_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryContactEntity _$BeneficiaryContactEntityFromJson(Map<String, dynamic> json) =>
    BeneficiaryContactEntity(
      beneficiarySendMoneyContactEntity: json['sm'] == null
          ? null
          : BeneficiarySendMoneyContactEntity.fromJson(json['sm'] as Map<String, dynamic>),
      beneficiaryRequestMoneyContactEntity: json['rtp'] == null
          ? null
          : BeneficiaryRequestMoneyContactEntity.fromJson(json['rtp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeneficiaryContactEntityToJson(BeneficiaryContactEntity instance) => <String, dynamic>{
      'sm': instance.beneficiarySendMoneyContactEntity,
      'rtp': instance.beneficiaryRequestMoneyContactEntity,
    };
