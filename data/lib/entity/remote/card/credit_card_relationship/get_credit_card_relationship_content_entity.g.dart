// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_relationship_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardRelationshipContentEntity _$GetCreditCardRelationshipContentEntityFromJson(
        Map<String, dynamic> json) =>
    GetCreditCardRelationshipContentEntity(
      relationshipList: (json['relationship'] as List<dynamic>?)
          ?.map((e) => GetComboValuesDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      minLimit: json['minLimit'] as num? ?? 0.0,
      maxLimit: json['maxLimit'] as num? ?? 0.0,
    );

Map<String, dynamic> _$GetCreditCardRelationshipContentEntityToJson(
        GetCreditCardRelationshipContentEntity instance) =>
    <String, dynamic>{
      'relationship': instance.relationshipList,
      'minLimit': instance.minLimit,
      'maxLimit': instance.maxLimit,
    };
