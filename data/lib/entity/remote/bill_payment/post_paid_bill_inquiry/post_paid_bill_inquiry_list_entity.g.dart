// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_paid_bill_inquiry_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaidBillInquiryListListEntity _$PostPaidBillInquiryListListEntityFromJson(Map<String, dynamic> json) =>
    PostPaidBillInquiryListListEntity(
      billInquiryResponses: (json['billInquiryResponses'] as List<dynamic>?)
          ?.map((e) => PostPaidBillInquiryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostPaidBillInquiryListListEntityToJson(PostPaidBillInquiryListListEntity instance) =>
    <String, dynamic>{
      'billInquiryResponses': instance.billInquiryResponses,
    };
