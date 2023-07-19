import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_list_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_response.g.dart';

@JsonSerializable()
class PostPaidBillInquiryResponse
    extends BaseLayerDataTransformer<PostPaidBillInquiryResponse, PostPaidBillInquiry> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PostPaidBillInquiryResponse({
    this.response,
  });

  factory PostPaidBillInquiryResponse.fromJson(Map<String, dynamic> json) =>
      _$PostPaidBillInquiryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaidBillInquiryResponseToJson(this);

  @override
  PostPaidBillInquiry transform() {
    return PostPaidBillInquiry(
      content: PostPaidBillInquiryListListEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
    );
  }
}
