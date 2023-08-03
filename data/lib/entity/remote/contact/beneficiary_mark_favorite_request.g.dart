// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_mark_favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryMarkFavoriteRequest _$BeneficiaryMarkFavoriteRequestFromJson(Map<String, dynamic> json) =>
    BeneficiaryMarkFavoriteRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String,
      isFavorite: json['IsFavorite'] as bool,
      userId: json['UserId'] as String,
      isFromMobile: json['IsFromMobile'] as bool,
      beneType: json['BeneType'] as String,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BeneficiaryMarkFavoriteRequestToJson(BeneficiaryMarkFavoriteRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'IsFavorite': instance.isFavorite,
      'UserId': instance.userId,
      'IsFromMobile': instance.isFromMobile,
      'BeneType': instance.beneType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
