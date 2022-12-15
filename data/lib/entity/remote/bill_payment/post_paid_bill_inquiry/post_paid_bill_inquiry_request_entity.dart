import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_request_entity.g.dart';

@JsonSerializable()
class PostPaidBillInquiryRequestEntity {
   @JsonKey(name: "postpaidBillInquiries")
  dynamic postpaidBillInquiries;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  PostPaidBillInquiryRequestEntity(
      {this.postpaidBillInquiries,
      this.getToken: true,
      required this.baseData});

  factory PostPaidBillInquiryRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$PostPaidBillInquiryRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PostPaidBillInquiryRequestEntityToJson(this);
}
