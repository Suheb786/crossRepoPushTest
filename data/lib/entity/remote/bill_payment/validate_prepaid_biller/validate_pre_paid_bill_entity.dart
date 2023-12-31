import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_pre_paid_bill_entity.g.dart';

@JsonSerializable()
class ValidatePrePaidBillEntity
    extends BaseLayerDataTransformer<ValidatePrePaidBillEntity, ValidatePrePaidBillData> {
  @JsonKey(name: "success")
  dynamic success;
  @JsonKey(name: "message")
  dynamic message;
  @JsonKey(name: "billerCode")
  dynamic billerCode;
  @JsonKey(name: "billingNo")
  dynamic billingNo;
  @JsonKey(name: "customerName")
  dynamic customerName;
  @JsonKey(name: "dueAmount")
  dynamic dueAmount;
  @JsonKey(name: "feesAmount")
  dynamic feesAmount;
  @JsonKey(name: "validationCode")
  dynamic validationCode;

  ValidatePrePaidBillEntity(
      {this.success,
      this.message,
      this.billerCode,
      this.billingNo,
      this.customerName,
      this.dueAmount,
      this.feesAmount,
      this.validationCode});

  factory ValidatePrePaidBillEntity.fromJson(Map<String, dynamic> json) =>
      _$ValidatePrePaidBillEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatePrePaidBillEntityToJson(this);

  @override
  ValidatePrePaidBillEntity restore(ValidatePrePaidBillData data) {
    return ValidatePrePaidBillEntity();
  }

  @override
  ValidatePrePaidBillData transform() {
    return ValidatePrePaidBillData(
        success: this.success ?? false,
        message: this.message != null && this.message!.toString().isNotEmpty ? this.message : "",
        billerCode: this.billerCode != null && this.billerCode!.toString().isNotEmpty ? this.billerCode : "",
        billingNo: this.billingNo != null && this.billingNo!.toString().isNotEmpty ? this.billingNo : "",
        customerName:
            this.customerName != null && this.customerName!.toString().isNotEmpty ? this.customerName : "",
        dueAmount:
            this.dueAmount != null && this.dueAmount!.toString().isNotEmpty ? this.dueAmount.toString() : "0",
        feesAmount: this.feesAmount != null && this.feesAmount!.toString().isNotEmpty
            ? this.feesAmount.toString()
            : "0",
        validationCode: this.validationCode != null && this.validationCode!.toString().isNotEmpty
            ? this.validationCode
            : "");
  }
}
