import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_bill_categories_list_entity.g.dart';

@JsonSerializable()
class GetBillCategoriesListEntity extends BaseLayerDataTransformer<
    GetBillCategoriesListEntity, GetBillCategoriesList> {
  @JsonKey(name: "categoryName")
  final String? categoryName;
  @JsonKey(name: "iconCode")
  final dynamic iconCode;
  @JsonKey(name: "categoryNameAr")
  final String? categoryNameAr;

  GetBillCategoriesListEntity({
    this.categoryName,
    this.iconCode,
    this.categoryNameAr,
  });

  factory GetBillCategoriesListEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBillCategoriesListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillCategoriesListEntityToJson(this);

  @override
  GetBillCategoriesListEntity restore(GetBillCategoriesList data) {
    return GetBillCategoriesListEntity();
  }

  @override
  GetBillCategoriesList transform() {
    return GetBillCategoriesList(
      categoryName: this.categoryName ?? "",
      iconCode: this.iconCode?.toString() ?? "",
      categoryNameAr: this.categoryNameAr ?? "",
    );
  }
}
