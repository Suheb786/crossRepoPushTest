// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFavoriteRequest _$UpdateFavoriteRequestFromJson(Map<String, dynamic> json) => UpdateFavoriteRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      isSendMoneyFav: json['IsSendMoneyFav'] as bool?,
      isRequestMoneyFav: json['IsRequestMoneyFav'] as bool?,
      userId: json['UserId'] as String?,
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateFavoriteRequestToJson(UpdateFavoriteRequest instance) => <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'IsSendMoneyFav': instance.isSendMoneyFav,
      'IsRequestMoneyFav': instance.isRequestMoneyFav,
      'UserId': instance.userId,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
