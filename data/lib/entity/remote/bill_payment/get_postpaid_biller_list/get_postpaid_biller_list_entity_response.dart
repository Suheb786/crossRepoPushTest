import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
part 'get_postpaid_biller_list_entity_response.g.dart';

@JsonSerializable()
class GetPostpaidBillerListEntityResponse extends BaseLayerDataTransformer<
    GetPostpaidBillerListEntityResponse, GetPostpaidBillerListModel> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

 /* @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final dynamic requestDateTime;

  @JsonKey(name: "logId")
  final dynamic logId;*/

  GetPostpaidBillerListEntityResponse({
    this.content,
   /* this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory GetPostpaidBillerListEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostpaidBillerListEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostpaidBillerListEntityResponseToJson(this);

  @override
  GetPostpaidBillerListModel transform() {
    return GetPostpaidBillerListModel(
      getPostpaidBillerListContent: GetPostpaidBillerListEntity.fromJson(
        this.content ?? Map(),
      ).transform(),
      /*statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
