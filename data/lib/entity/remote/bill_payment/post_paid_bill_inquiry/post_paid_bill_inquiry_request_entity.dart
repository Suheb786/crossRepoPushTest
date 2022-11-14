import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_request_entity.g.dart';

@JsonSerializable()
class PostPaidBillInquiryRequestEntity {
  /*@JsonKey(name: "billerCode")
  String? billerCode;
  @JsonKey(name: "serviceType")
  String? serviceType;
  @JsonKey(name: "billingNumber")
  String? billingNumber;*/
  @JsonKey(name: "postpaidBillInquiries")
  dynamic postpaidBillInquiries;

  PostPaidBillInquiryRequestEntity(
      {this.postpaidBillInquiries});

  factory PostPaidBillInquiryRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$PostPaidBillInquiryRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PostPaidBillInquiryRequestEntityToJson(this);
}
