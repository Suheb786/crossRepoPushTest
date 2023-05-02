// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_step_two_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardStepTwoRequestEntity
    _$SupplementaryCreditCardStepTwoRequestEntityFromJson(
            Map<String, dynamic> json) =>
        SupplementaryCreditCardStepTwoRequestEntity(
          primaryCardId: json['PrimaryCardId'] as String?,
          secondaryCardId: json['SecondaryCardId'] as String?,
          getToken: json['GetToken'] as bool? ?? false,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$SupplementaryCreditCardStepTwoRequestEntityToJson(
        SupplementaryCreditCardStepTwoRequestEntity instance) =>
    <String, dynamic>{
      'PrimaryCardId': instance.primaryCardId,
      'SecondaryCardId': instance.secondaryCardId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
