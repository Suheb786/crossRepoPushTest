// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_categories_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersCategoriesRequestEntity _$OffersCategoriesRequestEntityFromJson(
        Map<String, dynamic> json) =>
    OffersCategoriesRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
    );

Map<String, dynamic> _$OffersCategoriesRequestEntityToJson(
        OffersCategoriesRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
