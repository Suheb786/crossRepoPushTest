// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_pre_paid_bill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePrePaidBillResponse _$ValidatePrePaidBillResponseFromJson(Map<String, dynamic> json) =>
    ValidatePrePaidBillResponse(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidatePrePaidBillResponseToJson(ValidatePrePaidBillResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
