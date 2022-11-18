import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_list_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_pre_paid_categories_response.g.dart';

@JsonSerializable()
class GetPrePaidCategoriesResponse extends BaseLayerDataTransformer<
    GetPrePaidCategoriesResponse, GetPrePaidCategoriesModel> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetPrePaidCategoriesResponse({
    this.response,
  });


  factory GetPrePaidCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPrePaidCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrePaidCategoriesResponseToJson(this);

  @override
  GetPrePaidCategoriesModel transform() {
    return GetPrePaidCategoriesModel(
      content: GetPrePaidCategoriesListEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
     /* statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
