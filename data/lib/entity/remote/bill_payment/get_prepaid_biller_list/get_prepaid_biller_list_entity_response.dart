import 'package:data/entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_prepaid_biller_list_entity_response.g.dart';

@JsonSerializable()
class GetPrepaidBillerListEntityResponse
    extends BaseLayerDataTransformer<GetPrepaidBillerListEntityResponse, GetPrepaidBillerListModel> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetPrepaidBillerListEntityResponse({
    this.response,
  });

  factory GetPrepaidBillerListEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPrepaidBillerListEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrepaidBillerListEntityResponseToJson(this);

  @override
  GetPrepaidBillerListModel transform() {
    return GetPrepaidBillerListModel(
      getPrepaidBillerListContent: GetPrepaidBillerListEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
    );
  }
}
