// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_categories_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersCategoriesResponseEntity _$OffersCategoriesResponseEntityFromJson(Map<String, dynamic> json) =>
    OffersCategoriesResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersCategoriesResponseEntityToJson(OffersCategoriesResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
