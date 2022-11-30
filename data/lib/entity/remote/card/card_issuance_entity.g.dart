// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_issuance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardIssuanceEntity _$CardIssuanceEntityFromJson(Map<String, dynamic> json) {
  return CardIssuanceEntity(
    nameOnCard: json['nameOnCard'] as String?,
    cardNumber: json['cardNumber'] as String?,
    pan: json['pan'] as String?,
  );
}

Map<String, dynamic> _$CardIssuanceEntityToJson(CardIssuanceEntity instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'pan': instance.pan,
      'nameOnCard': instance.nameOnCard,
    };
