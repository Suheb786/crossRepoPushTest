// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_paid_bill_inquiry_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaidBillInquiryRequestEntity _$PostPaidBillInquiryRequestEntityFromJson(Map<String, dynamic> json) =>
    PostPaidBillInquiryRequestEntity(
      postpaidBillInquiries: json['postpaidBillInquiries'],
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PostPaidBillInquiryRequestEntityToJson(PostPaidBillInquiryRequestEntity instance) =>
    <String, dynamic>{
      'postpaidBillInquiries': instance.postpaidBillInquiries,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
