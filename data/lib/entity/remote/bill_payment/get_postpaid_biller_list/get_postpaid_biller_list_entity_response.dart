import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_postpaid_biller_list_entity_response.g.dart';

@JsonSerializable()
class GetPostpaidBillerListEntityResponse
    extends BaseLayerDataTransformer<GetPostpaidBillerListEntityResponse, GetPostpaidBillerListModel> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetPostpaidBillerListEntityResponse({
    this.response,
  });

  factory GetPostpaidBillerListEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostpaidBillerListEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostpaidBillerListEntityResponseToJson(this);

  @override
  GetPostpaidBillerListModel transform() {
    return GetPostpaidBillerListModel(
      getPostpaidBillerListContent: GetPostpaidBillerListEntity.fromJson(this.response?.content).transform(),
    );
  }
}
