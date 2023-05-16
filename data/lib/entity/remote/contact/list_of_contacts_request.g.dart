// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_contacts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfContactRequest _$ListOfContactRequestFromJson(Map<String, dynamic> json) => ListOfContactRequest(
      isFromMobile: json['IsFromMobile'] as bool?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ListOfContactRequestToJson(ListOfContactRequest instance) => <String, dynamic>{
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
