// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_send_money_contact_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiarySendMoneyContactEntity _$BeneficiarySendMoneyContactEntityFromJson(
        Map<String, dynamic> json) =>
    BeneficiarySendMoneyContactEntity(
      beneficiaryFavoriteContactEntity:
          (json['favoriteContacts'] as List<dynamic>?)
                  ?.map((e) => BeneficiaryFavoriteContactEntity.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
      beneficiaryOtherContactEntity: (json['otherContacts'] as List<dynamic>?)
              ?.map((e) => BeneficiaryOtherContactEntity.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BeneficiarySendMoneyContactEntityToJson(
        BeneficiarySendMoneyContactEntity instance) =>
    <String, dynamic>{
      'favoriteContacts': instance.beneficiaryFavoriteContactEntity,
      'otherContacts': instance.beneficiaryOtherContactEntity,
    };
