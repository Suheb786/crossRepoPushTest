import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model.dart';
import 'add_new_prepaid_biller_entity_data.dart';

part 'add_new_prepaid_biller_entity_response.g.dart';


@JsonSerializable()
class AddNewPrepaidBillerEntityResponse
    extends BaseLayerDataTransformer<AddNewPrepaidBillerEntityResponse, AddNewPrepaidBillerModel> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

 /* @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final String? requestDateTime;

  @JsonKey(name: "logId")
  final String? logId;
*/
  AddNewPrepaidBillerEntityResponse({
    this.content,
    /*this.status,
    this.logId,
    this.requestDateTime,*/
  });

  factory AddNewPrepaidBillerEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$AddNewPrepaidBillerEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewPrepaidBillerEntityResponseToJson(this);

  @override
  AddNewPrepaidBillerModel transform() {
    return AddNewPrepaidBillerModel(
      addNewPrepaidBillerModelData: AddNewPrepaidBillerEntityData.fromJson(
        this.content ?? Map(),
      ).transform(),
    /*  statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
