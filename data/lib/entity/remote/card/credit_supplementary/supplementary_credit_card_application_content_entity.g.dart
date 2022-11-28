// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_application_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardApplicationContentEntity _$SupplementaryCreditCardApplicationContentEntityFromJson(
    Map<String, dynamic> json) {
  return SupplementaryCreditCardApplicationContentEntity(
    createdDate: json['createdDate'] as String?,
    primaryCardId: json['primaryCardId'] as String?,
    supCardId: json['supCardId'] as String?,
    step1: json['step1'] as bool?,
    issueCardDate: json['issueCardDate'] as String?,
    step2: json['step2'] as bool?,
    step3: json['step3'] as bool?,
    contactLessError: json['contactLessError'] as int?,
    aramexError: json['aramexError'] as int?,
  );
}

Map<String, dynamic> _$SupplementaryCreditCardApplicationContentEntityToJson(
        SupplementaryCreditCardApplicationContentEntity instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'primaryCardId': instance.primaryCardId,
      'supCardId': instance.supCardId,
      'step1': instance.step1,
      'issueCardDate': instance.issueCardDate,
      'step2': instance.step2,
      'step3': instance.step3,
      'contactLessError': instance.contactLessError,
      'aramexError': instance.aramexError,
    };
