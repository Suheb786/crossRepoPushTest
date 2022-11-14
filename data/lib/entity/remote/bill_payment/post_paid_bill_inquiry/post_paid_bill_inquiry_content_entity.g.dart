// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_paid_bill_inquiry_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaidBillInquiryContentEntity _$PostPaidBillInquiryContentEntityFromJson(
    Map<String, dynamic> json) {
  return PostPaidBillInquiryContentEntity(
    content: json['content'] == null
        ? null
        : PostPaidBillInquiryEntity.fromJson(
            json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostPaidBillInquiryContentEntityToJson(
        PostPaidBillInquiryContentEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
