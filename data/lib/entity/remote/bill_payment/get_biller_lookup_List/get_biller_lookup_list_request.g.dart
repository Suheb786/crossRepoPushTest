// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_biller_lookup_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillerLookupListRequest _$GetBillerLookupListRequestFromJson(
    Map<String, dynamic> json) {
  return GetBillerLookupListRequest(
    categoryName: json['categoryName'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetBillerLookupListRequestToJson(
        GetBillerLookupListRequest instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
