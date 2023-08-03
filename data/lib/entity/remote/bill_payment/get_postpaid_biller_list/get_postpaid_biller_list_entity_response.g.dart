// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_postpaid_biller_list_entity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostpaidBillerListEntityResponse
    _$GetPostpaidBillerListEntityResponseFromJson(Map<String, dynamic> json) =>
        GetPostpaidBillerListEntityResponse(
          response: json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetPostpaidBillerListEntityResponseToJson(
        GetPostpaidBillerListEntityResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
