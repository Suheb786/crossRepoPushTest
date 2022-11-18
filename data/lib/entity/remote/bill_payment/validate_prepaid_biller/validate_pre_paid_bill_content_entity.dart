import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_pre_paid_bill_content_entity.g.dart';

@JsonSerializable()
class ValidatePrePaidBillContentEntity extends BaseLayerDataTransformer<
    ValidatePrePaidBillContentEntity, ValidatePrePaidBillContent> {
  @JsonKey(name: "content")
  dynamic content;

  ValidatePrePaidBillContentEntity({this.content});

  factory ValidatePrePaidBillContentEntity.fromJson(
          Map<String, dynamic> json) =>
      _$ValidatePrePaidBillContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ValidatePrePaidBillContentEntityToJson(this);

  @override
  ValidatePrePaidBillContentEntity restore(ValidatePrePaidBillContent data) {
    return ValidatePrePaidBillContentEntity();
  }

  @override
  ValidatePrePaidBillContent transform() {
    return ValidatePrePaidBillContent(
      content: content,
    );
  }
}
