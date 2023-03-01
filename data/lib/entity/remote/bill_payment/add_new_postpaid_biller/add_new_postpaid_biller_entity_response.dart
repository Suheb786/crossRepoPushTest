import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'add_new_postpaid_biller_entity_data.dart';

part 'add_new_postpaid_biller_entity_response.g.dart';


@JsonSerializable()
class AddNewPostpaidBillerEntityResponse
    extends BaseLayerDataTransformer<AddNewPostpaidBillerEntityResponse, AddNewPostpaidBillerModel> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AddNewPostpaidBillerEntityResponse({
    this.response,
  });



  factory AddNewPostpaidBillerEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$AddNewPostpaidBillerEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewPostpaidBillerEntityResponseToJson(this);

  @override
  AddNewPostpaidBillerModel transform() {
    return AddNewPostpaidBillerModel(
      addNewPostpaidBillerModelData: AddNewPostpaidBillerEntityData.fromJson(
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
