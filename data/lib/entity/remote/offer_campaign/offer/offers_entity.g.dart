// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersEntity _$OffersEntityFromJson(Map<String, dynamic> json) => OffersEntity(
      id: json['id'] as num? ?? 0,
      label: json['label'] as String? ?? '',
      campaignId: json['campaignId'] as num? ?? 0.0,
      campaignCategories: json['campaignCategories'] as String? ?? '',
      campaignNameAr: json['campaignNameAr'] as String? ?? '',
      campaignNameEn: json['campaignNameEn'] as String? ?? '',
      campaignValidTill: json['campaignValidTill'] as String? ?? '',
      createdOn: json['createdOn'] as String? ?? '',
      descriptionsAr: json['descriptionsAr'] as String? ?? '',
      descriptionsEn: json['descriptionsEn'] as String? ?? '',
      link: json['link'] as String? ?? '',
      termsAndConditions: json['termsAndConditions'] as String? ?? '',
      image: json['image'] ?? '',
    );

Map<String, dynamic> _$OffersEntityToJson(OffersEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'campaignId': instance.campaignId,
      'campaignCategories': instance.campaignCategories,
      'campaignNameAr': instance.campaignNameAr,
      'campaignNameEn': instance.campaignNameEn,
      'campaignValidTill': instance.campaignValidTill,
      'createdOn': instance.createdOn,
      'descriptionsAr': instance.descriptionsAr,
      'descriptionsEn': instance.descriptionsEn,
      'link': instance.link,
      'termsAndConditions': instance.termsAndConditions,
      'image': instance.image,
    };
