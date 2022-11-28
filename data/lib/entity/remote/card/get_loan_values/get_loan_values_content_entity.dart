import 'package:domain/model/card/get_loan_values/get_loan_values_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_loan_values_content_entity.g.dart";

@JsonSerializable()
class GetLoanValuesContentEntity
    implements BaseLayerDataTransformer<GetLoanValuesContentEntity, GetLoanValuesContent> {
  @JsonKey(name: "loanValueId")
  final num? loanValueId;
  @JsonKey(name: "minimumLimit")
  final String? minimumLimit;
  @JsonKey(name: "step")
  final String? step;
  @JsonKey(name: "maxLimit")
  final num? maxLimit;

  GetLoanValuesContentEntity({this.maxLimit, this.loanValueId: 0, this.minimumLimit, this.step});

  factory GetLoanValuesContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetLoanValuesContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanValuesContentEntityToJson(this);

  @override
  GetLoanValuesContentEntity restore(GetLoanValuesContent response) {
    return GetLoanValuesContentEntity();
  }

  @override
  GetLoanValuesContent transform() {
    return GetLoanValuesContent(
        loanValueId: this.loanValueId,
        maxLimit: this.maxLimit,
        minimumLimit: this.minimumLimit,
        step: this.step);
  }
}
