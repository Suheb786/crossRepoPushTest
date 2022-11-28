import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "additional_income.g.dart";

@JsonSerializable()
class AdditionalIncome extends BaseLayerDataTransformer<AdditionalIncome, AdditionalIncomeType> {
  @JsonKey(name: "AdditionalIncomeSource")
  final String? additionalIncomeSource;
  @JsonKey(name: "TotalIncome")
  final String? totalIncome;

  AdditionalIncome({this.additionalIncomeSource, this.totalIncome});

  factory AdditionalIncome.fromJson(Map<String, dynamic> json) => _$AdditionalIncomeFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalIncomeToJson(this);

  @override
  AdditionalIncome restore(AdditionalIncomeType data) {
    return AdditionalIncome(
        additionalIncomeSource: data.additionalIncomeSource, totalIncome: data.totalIncome);
  }

  @override
  AdditionalIncomeType transform() {
    return AdditionalIncomeType(additionalIncomeSource: additionalIncomeSource, totalIncome: totalIncome);
  }
}
