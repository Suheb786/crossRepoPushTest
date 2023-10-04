// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersCategoriesEntity _$OffersCategoriesEntityFromJson(Map<String, dynamic> json) => OffersCategoriesEntity(
      id: json['id'] as num? ?? 0,
      categoryId: json['categoryId'] as num? ?? 0,
      categoryNameEn: json['categoryNameEn'] as String? ?? '',
      categoryNameAr: json['categoryNameAr'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$OffersCategoriesEntityToJson(OffersCategoriesEntity instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'categoryNameEn': instance.categoryNameEn,
      'categoryNameAr': instance.categoryNameAr,
      'isActive': instance.isActive,
    };
