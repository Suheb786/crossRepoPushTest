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
  DateTime? dueDate;
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
  @JsonKey(name: "IsPartial")
  bool? IsPartial;

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
    this.IsPartial,
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
        message: this.message ?? "",
        billerCode: this.billerCode ?? "",
        billingNo: this.billingNo ?? "0",
        billNo: this.billNo ?? "0",
        dueAmount: this.dueAmount ?? "0",
        dueDate: this.dueDate ?? DateTime.now(),
        feesAmt: this.feesAmt ?? "0",
        serviceType: this.serviceType ?? "",
        success: this.success ?? false,
        IsPartial: this.IsPartial ?? false);
  }
}
