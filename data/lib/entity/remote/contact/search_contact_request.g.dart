// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchContactRequest _$SearchContactRequestFromJson(Map<String, dynamic> json) => SearchContactRequest(
      searchText: json['SearchText'] as String,
      isFromMobile: json['IsFromMobile'] as bool,
      beneType: json['BeneType'] as String,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SearchContactRequestToJson(SearchContactRequest instance) => <String, dynamic>{
      'SearchText': instance.searchText,
      'IsFromMobile': instance.isFromMobile,
      'BeneType': instance.beneType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
