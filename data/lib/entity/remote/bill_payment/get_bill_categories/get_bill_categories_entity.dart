import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'get_bill_categories_data_entity.dart';

part 'get_bill_categories_entity.g.dart';

@JsonSerializable()
class GetBillCategoriesEntity extends BaseLayerDataTransformer<GetBillCategoriesEntity, GetBillCategories> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetBillCategoriesEntity({
    this.response,
  });

  factory GetBillCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBillCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillCategoriesEntityToJson(this);

  @override
  GetBillCategories transform() {
    return GetBillCategories(
      getBillCategoriesData: GetBillCategoriesDataEntity.fromJson(
        this.response?.content ?? Map<String, dynamic>(),
      ).transform(),
      /* statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
