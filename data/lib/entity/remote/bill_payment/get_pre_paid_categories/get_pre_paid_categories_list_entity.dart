import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_entity.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_pre_paid_categories_list_entity.g.dart';

@JsonSerializable()
class GetPrePaidCategoriesListEntity
    extends BaseLayerDataTransformer<GetPrePaidCategoriesListEntity, GetPrePaidCategoriesModelContent> {
  @JsonKey(name: "categories")
  List<GetPrePaidCategoriesEntity>? getPrePaidCategoriesEntity;

  GetPrePaidCategoriesListEntity({this.getPrePaidCategoriesEntity});

  factory GetPrePaidCategoriesListEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPrePaidCategoriesListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrePaidCategoriesListEntityToJson(this);

  @override
  GetPrePaidCategoriesListEntity restore(GetPrePaidCategoriesModelContent data) {
    return GetPrePaidCategoriesListEntity();
  }

  @override
  GetPrePaidCategoriesModelContent transform() {
    return GetPrePaidCategoriesModelContent(
        getPrepaidBillerListModelData: this.getPrePaidCategoriesEntity?.map((e) => e.transform()).toList());
  }
}
