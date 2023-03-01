// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_biller_lookup_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillerLookupListResponse _$GetBillerLookupListResponseFromJson(
    Map<String, dynamic> json) {
  return GetBillerLookupListResponse(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetBillerLookupListResponseToJson(
        GetBillerLookupListResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
