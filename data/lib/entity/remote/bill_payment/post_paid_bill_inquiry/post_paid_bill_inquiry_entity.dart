import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_paid_bill_inquiry_entity.g.dart';

@JsonSerializable()
class PostPaidBillInquiryEntity extends BaseLayerDataTransformer<
    PostPaidBillInquiryEntity, PostPaidBillInquiryData> {
  @JsonKey(name: "billerCode")
  String? billerCode;
  @JsonKey(name: "billingNo")
  String? billingNo;
  @JsonKey(name: "billNo")
  String? billNo;
  @JsonKey(name: "dueDate")
  String? dueDate;
  @JsonKey(name: "serviceType")
  String? serviceType;
  @JsonKey(name: "dueAmount")
  String? dueAmount;
  @JsonKey(name: "feesAmt")
  String? feesAmt;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  dynamic message;
  @JsonKey(name: "isPartial")
  bool? isPartial;

  PostPaidBillInquiryEntity({
    this.serviceType,
    this.billerCode,
    this.message,
    this.success,
    this.billingNo,
    this.billNo,
    this.dueAmount,
    this.dueDate,
    this.feesAmt,
    this.isPartial,
  });

  factory PostPaidBillInquiryEntity.fromJson(Map<String, dynamic> json) =>
      _$PostPaidBillInquiryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaidBillInquiryEntityToJson(this);

  @override
  PostPaidBillInquiryEntity restore(PostPaidBillInquiryData data) {
    return PostPaidBillInquiryEntity();
  }

  @override
  PostPaidBillInquiryData transform() {
    return PostPaidBillInquiryData(
        message: this.message != null && this.message!.isNotEmpty
            ? this.message
            : "",
        billerCode: this.billerCode != null && this.billerCode!.isNotEmpty
            ? this.billerCode
            : "0",
        billingNo: this.billingNo != null && this.billingNo!.isNotEmpty
            ? this.billingNo
            : "",
        billNo:
            this.billNo != null && this.billNo!.isNotEmpty ? this.billNo : "",
        dueAmount: this.dueAmount != null && this.dueAmount!.isNotEmpty
            ? this.dueAmount
            : "0",
        dueDate: this.dueDate != null && this.dueDate!.isNotEmpty
            ? this.dueDate
            : "",
        feesAmt: this.feesAmt != null && this.feesAmt!.isNotEmpty
            ? this.feesAmt
            : "",
        serviceType: this.serviceType != null && this.serviceType!.isNotEmpty
            ? this.serviceType
            : "",
        success: this.success ?? false,
        isPartial: this.isPartial ?? false);
  }
}
