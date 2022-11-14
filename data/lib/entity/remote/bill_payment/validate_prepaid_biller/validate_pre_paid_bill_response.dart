import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_entity.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_content_entity.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_pre_paid_bill_response.g.dart';

@JsonSerializable()
class ValidatePrePaidBillResponse
    extends BaseLayerDataTransformer<ValidatePrePaidBillResponse, ValidatePrePaidBill> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

 /* @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final String? requestDateTime;

  @JsonKey(name: "logId")
  final String? logId;*/

  ValidatePrePaidBillResponse({
    this.content,
    /*this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory ValidatePrePaidBillResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidatePrePaidBillResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatePrePaidBillResponseToJson(this);

  @override
  ValidatePrePaidBill transform() {
    return ValidatePrePaidBill(
      content: ValidatePrePaidBillEntity.fromJson(
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
