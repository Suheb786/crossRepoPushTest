// import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_entity.dart';
// import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_content.dart';
// import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'post_paid_bill_inquiry_content_entity.g.dart';
//
// @JsonSerializable()
// class PostPaidBillInquiryContentEntity extends BaseLayerDataTransformer<
//     PostPaidBillInquiryContentEntity, PostPaidBillInquiryContent> {
//   @JsonKey(name: "content")
//   PostPaidBillInquiryEntity? content;
//
//   PostPaidBillInquiryContentEntity({this.content});
//
//   factory PostPaidBillInquiryContentEntity.fromJson(
//           Map<String, dynamic> json) =>
//       _$PostPaidBillInquiryContentEntityFromJson(json);
//
//   Map<String, dynamic> toJson() =>
//       _$PostPaidBillInquiryContentEntityToJson(this);
//
//   @override
//   PostPaidBillInquiryContentEntity restore(PostPaidBillInquiryContent data) {
//     return PostPaidBillInquiryContentEntity();
//   }
//
//   @override
//   PostPaidBillInquiryContent transform() {
//     return PostPaidBillInquiryContent(
//       paidBillInquiryData: content!.transform(),
//     );
//   }
// }
