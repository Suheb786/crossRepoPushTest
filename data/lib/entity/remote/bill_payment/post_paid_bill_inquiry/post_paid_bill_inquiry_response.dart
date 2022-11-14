import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_list_entity.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_response.g.dart';

@JsonSerializable()
class PostPaidBillInquiryResponse extends BaseLayerDataTransformer<
    PostPaidBillInquiryResponse, PostPaidBillInquiry> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

 /* @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final String? requestDateTime;

  @JsonKey(name: "logId")
  final String? logId;
*/
  PostPaidBillInquiryResponse({
    this.content,
    /*this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory PostPaidBillInquiryResponse.fromJson(Map<String, dynamic> json) =>
      _$PostPaidBillInquiryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaidBillInquiryResponseToJson(this);

  @override
  PostPaidBillInquiry transform() {
    return PostPaidBillInquiry(
      content: PostPaidBillInquiryListListEntity.fromJson(
        this.content ?? Map(),
      ).transform(),
      /*statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
