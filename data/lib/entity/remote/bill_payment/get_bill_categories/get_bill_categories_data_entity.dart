import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_data.dart';
import 'get_bill_categories_list_entity.dart';

part 'get_bill_categories_data_entity.g.dart';

@JsonSerializable()
class GetBillCategoriesDataEntity extends BaseLayerDataTransformer<
    GetBillCategoriesDataEntity, GetBillCategoriesData> {
  @JsonKey(name: "categoriesList")
  final List<GetBillCategoriesListEntity>? getBillCategoriesList;

  GetBillCategoriesDataEntity({
    this.getBillCategoriesList,
  });

  factory GetBillCategoriesDataEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBillCategoriesDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillCategoriesDataEntityToJson(this);

  @override
  GetBillCategoriesDataEntity restore(GetBillCategoriesData data) {
    return GetBillCategoriesDataEntity();
  }

  @override
  GetBillCategoriesData transform() {
    return GetBillCategoriesData(
        getBillCategoriesList:
            this.getBillCategoriesList!.map((e) => e.transform()).toList());
  }
}
