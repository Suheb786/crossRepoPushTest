// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_postpaid_biller_entity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewPostpaidBillerEntityResponse _$AddNewPostpaidBillerEntityResponseFromJson(
        Map<String, dynamic> json) =>
    AddNewPostpaidBillerEntityResponse(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddNewPostpaidBillerEntityResponseToJson(
        AddNewPostpaidBillerEntityResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
