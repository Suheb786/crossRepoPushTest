// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_prepaid_bill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPrePaidResponse _$PayPrePaidResponseFromJson(Map<String, dynamic> json) =>
    PayPrePaidResponse(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayPrePaidResponseToJson(PayPrePaidResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
