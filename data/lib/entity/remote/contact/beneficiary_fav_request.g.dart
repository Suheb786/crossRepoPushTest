// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_fav_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryFavoriteRequest _$BeneficiaryFavoriteRequestFromJson(Map<String, dynamic> json) =>
    BeneficiaryFavoriteRequest(
      isFromMobile: json['IsFromMobile'] as bool,
      beneType: json['BeneType'] as String,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BeneficiaryFavoriteRequestToJson(BeneficiaryFavoriteRequest instance) =>
    <String, dynamic>{
      'IsFromMobile': instance.isFromMobile,
      'BeneType': instance.beneType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
