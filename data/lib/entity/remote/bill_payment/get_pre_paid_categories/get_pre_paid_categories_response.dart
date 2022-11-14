import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_list_entity.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_pre_paid_categories_response.g.dart';

@JsonSerializable()
class GetPrePaidCategoriesResponse extends BaseLayerDataTransformer<
    GetPrePaidCategoriesResponse, GetPrePaidCategoriesModel> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

  /*@JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final String? requestDateTime;

  @JsonKey(name: "logId")
  final String? logId;*/

  GetPrePaidCategoriesResponse({
    this.content,
    /*this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory GetPrePaidCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPrePaidCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrePaidCategoriesResponseToJson(this);

  @override
  GetPrePaidCategoriesModel transform() {
    return GetPrePaidCategoriesModel(
      content: GetPrePaidCategoriesListEntity.fromJson(
        this.content ?? Map(),
      ).transform(),
     /* statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
