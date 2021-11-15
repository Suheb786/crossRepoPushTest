// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_country_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchCountryListRequest _$FetchCountryListRequestFromJson(
    Map<String, dynamic> json) {
  return FetchCountryListRequest(
    getToken: json['getToken'] as bool?,
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FetchCountryListRequestToJson(
        FetchCountryListRequest instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
