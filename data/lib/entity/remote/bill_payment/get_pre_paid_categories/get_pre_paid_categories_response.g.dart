// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pre_paid_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrePaidCategoriesResponse _$GetPrePaidCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetPrePaidCategoriesResponse(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPrePaidCategoriesResponseToJson(
        GetPrePaidCategoriesResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
