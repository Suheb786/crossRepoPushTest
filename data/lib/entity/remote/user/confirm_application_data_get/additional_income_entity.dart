import 'package:domain/model/user/confirm_application_data_get/additional_income_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional_income_entity.g.dart';

@JsonSerializable()
class AdditionalIncomeEntity
    implements
        BaseLayerDataTransformer<AdditionalIncomeEntity, AdditionalIncomeInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "additionalIncomeSource")
  final String? additionalIncomeSource;
  @JsonKey(name: "totalIncome")
  final String? totalIncome;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;

  AdditionalIncomeEntity({this.id,
    this.userId,
    this.additionalIncomeSource,
    this.totalIncome,
    this.createdOn});

  factory AdditionalIncomeEntity.fromJson(Map<String, dynamic> json) =>
      _$AdditionalIncomeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalIncomeEntityToJson(this);

  @override
  AdditionalIncomeEntity restore(AdditionalIncomeInfo response) {
    return AdditionalIncomeEntity(
        id: response.id,
        createdOn: response.createdOn,
        additionalIncomeSource: response.additionalIncomeSource,
        totalIncome: response.totalIncome,
        userId: response.userId);
  }

  @override
  AdditionalIncomeInfo transform() {
    return AdditionalIncomeInfo(
        id: this.id,
        createdOn: this.createdOn,
        userId: this.userId,
        additionalIncomeSource: this.additionalIncomeSource,
        totalIncome: this.totalIncome);
  }
}
