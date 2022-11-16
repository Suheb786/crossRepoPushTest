// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_prepaid_biller_list_entity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrepaidBillerListEntityResponse _$GetPrepaidBillerListEntityResponseFromJson(
    Map<String, dynamic> json) {
  return GetPrepaidBillerListEntityResponse(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetPrepaidBillerListEntityResponseToJson(
        GetPrepaidBillerListEntityResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
