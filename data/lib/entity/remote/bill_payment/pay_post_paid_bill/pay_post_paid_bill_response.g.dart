// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_post_paid_bill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPostPaidBillResponse _$PayPostPaidBillResponseFromJson(Map<String, dynamic> json) =>
    PayPostPaidBillResponse(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayPostPaidBillResponseToJson(PayPostPaidBillResponse instance) => <String, dynamic>{
      'response': instance.response,
    };
