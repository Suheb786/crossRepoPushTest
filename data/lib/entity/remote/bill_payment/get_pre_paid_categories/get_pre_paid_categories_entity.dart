import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_pre_paid_categories_entity.g.dart';

@JsonSerializable()
class GetPrePaidCategoriesEntity
    extends BaseLayerDataTransformer<GetPrePaidCategoriesEntity, GetPrepaidCategoriesModelData> {
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "type")
  String? type;

  GetPrePaidCategoriesEntity({this.code, this.description});

  factory GetPrePaidCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPrePaidCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrePaidCategoriesEntityToJson(this);

  @override
  GetPrePaidCategoriesEntity restore(GetPrepaidCategoriesModelData data) {
    return GetPrePaidCategoriesEntity();
  }

  @override
  GetPrepaidCategoriesModelData transform() {
    return GetPrepaidCategoriesModelData(code: this.code, description: this.description, type: this.type);
  }
}
