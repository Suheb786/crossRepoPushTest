// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_step_three_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardStepThreeRequestEntity
    _$SupplementaryCreditCardStepThreeRequestEntityFromJson(
            Map<String, dynamic> json) =>
        SupplementaryCreditCardStepThreeRequestEntity(
          primaryCardId: json['PrimaryCardId'] as String?,
          secondaryCardId: json['SecondaryCardId'] as String?,
          accountNumber: json['AccountNumber'] as String?,
          getToken: json['GetToken'] as bool? ?? false,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$SupplementaryCreditCardStepThreeRequestEntityToJson(
        SupplementaryCreditCardStepThreeRequestEntity instance) =>
    <String, dynamic>{
      'PrimaryCardId': instance.primaryCardId,
      'SecondaryCardId': instance.secondaryCardId,
      'AccountNumber': instance.accountNumber,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
