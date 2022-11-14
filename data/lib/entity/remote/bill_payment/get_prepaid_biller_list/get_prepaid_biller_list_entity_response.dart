import 'package:data/entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
part 'get_prepaid_biller_list_entity_response.g.dart';

@JsonSerializable()
class GetPrepaidBillerListEntityResponse extends BaseLayerDataTransformer<
    GetPrepaidBillerListEntityResponse, GetPrepaidBillerListModel> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

  /*@JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final dynamic requestDateTime;

  @JsonKey(name: "logId")
  final dynamic logId;
*/
  GetPrepaidBillerListEntityResponse({
    this.content,
    /*this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory GetPrepaidBillerListEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPrepaidBillerListEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrepaidBillerListEntityResponseToJson(this);

  @override
  GetPrepaidBillerListModel transform() {
    return GetPrepaidBillerListModel(
      getPrepaidBillerListContent: GetPrepaidBillerListEntity.fromJson(
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
