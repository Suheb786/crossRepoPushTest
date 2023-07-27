import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_pre_paid_bill_response.g.dart';

@JsonSerializable()
class ValidatePrePaidBillResponse
    extends BaseLayerDataTransformer<ValidatePrePaidBillResponse, ValidatePrePaidBill> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ValidatePrePaidBillResponse({
    this.response,
  });

  factory ValidatePrePaidBillResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidatePrePaidBillResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatePrePaidBillResponseToJson(this);

  @override
  ValidatePrePaidBill transform() {
    return ValidatePrePaidBill(
      content: ValidatePrePaidBillEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
    );
  }
}
