// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_prepaid_biller_entity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewPrepaidBillerEntityResponse _$AddNewPrepaidBillerEntityResponseFromJson(
    Map<String, dynamic> json) {
  return AddNewPrepaidBillerEntityResponse(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddNewPrepaidBillerEntityResponseToJson(
        AddNewPrepaidBillerEntityResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
