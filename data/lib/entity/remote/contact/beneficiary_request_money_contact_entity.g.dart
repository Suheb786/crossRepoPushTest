// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_request_money_contact_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryRequestMoneyContactEntity
    _$BeneficiaryRequestMoneyContactEntityFromJson(Map<String, dynamic> json) =>
        BeneficiaryRequestMoneyContactEntity(
          beneficiaryFavoriteContactEntity:
              (json['favoriteContacts'] as List<dynamic>?)
                      ?.map((e) => BeneficiaryFavoriteContactEntity.fromJson(
                          e as Map<String, dynamic>))
                      .toList() ??
                  [],
          beneficiaryOtherContactEntity:
              (json['otherContacts'] as List<dynamic>?)
                      ?.map((e) => BeneficiaryOtherContactEntity.fromJson(
                          e as Map<String, dynamic>))
                      .toList() ??
                  [],
        );

Map<String, dynamic> _$BeneficiaryRequestMoneyContactEntityToJson(
        BeneficiaryRequestMoneyContactEntity instance) =>
    <String, dynamic>{
      'favoriteContacts': instance.beneficiaryFavoriteContactEntity,
      'otherContacts': instance.beneficiaryOtherContactEntity,
    };
