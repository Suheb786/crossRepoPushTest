// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_paid_bill_inquiry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaidBillInquiryResponse _$PostPaidBillInquiryResponseFromJson(
        Map<String, dynamic> json) =>
    PostPaidBillInquiryResponse(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostPaidBillInquiryResponseToJson(
        PostPaidBillInquiryResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
