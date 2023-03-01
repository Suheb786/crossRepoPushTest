import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_entity.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_list_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_list_entity.g.dart';

@JsonSerializable()
class PostPaidBillInquiryListListEntity extends BaseLayerDataTransformer<
    PostPaidBillInquiryListListEntity, PostPaidBillInquiryListData> {
  @JsonKey(name: "billInquiryResponses")
  List<PostPaidBillInquiryEntity>? billInquiryResponses;

  PostPaidBillInquiryListListEntity({this.billInquiryResponses});

  factory PostPaidBillInquiryListListEntity.fromJson(
          Map<String, dynamic> json) =>
      _$PostPaidBillInquiryListListEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PostPaidBillInquiryListListEntityToJson(this);

  @override
  PostPaidBillInquiryListListEntity restore(PostPaidBillInquiryListData data) {
    return PostPaidBillInquiryListListEntity();
  }

  @override
  PostPaidBillInquiryListData transform() {
    return PostPaidBillInquiryListData(
        postPaidBillInquiryData:
            this.billInquiryResponses?.map((e) => e.transform()).toList());
  }
}
