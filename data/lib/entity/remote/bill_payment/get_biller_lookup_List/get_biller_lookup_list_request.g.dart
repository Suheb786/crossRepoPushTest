// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_biller_lookup_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillerLookupListRequest _$GetBillerLookupListRequestFromJson(Map<String, dynamic> json) =>
    GetBillerLookupListRequest(
      categoryName: json['categoryName'] as String?,
      type: json['Type'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetBillerLookupListRequestToJson(GetBillerLookupListRequest instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'Type': instance.type,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
