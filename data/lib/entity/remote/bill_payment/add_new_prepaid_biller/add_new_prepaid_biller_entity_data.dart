import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_new_prepaid_biller_entity_data.g.dart';

@JsonSerializable()
class AddNewPrepaidBillerEntityData extends BaseLayerDataTransformer<
    AddNewPrepaidBillerEntityData, AddNewPrepaidBillerModelData> {

  @JsonKey(name: "nickName")
  String? nickName;

  AddNewPrepaidBillerEntityData({
    this.nickName,
  });

  factory AddNewPrepaidBillerEntityData.fromJson(Map<String, dynamic> json) =>
      _$AddNewPrepaidBillerEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewPrepaidBillerEntityDataToJson(this);

  @override
  AddNewPrepaidBillerEntityData restore(AddNewPrepaidBillerModelData data) {
    return AddNewPrepaidBillerEntityData(
        nickName: data.nickName);
  }

  @override
  AddNewPrepaidBillerModelData transform() {
    return AddNewPrepaidBillerModelData(
        nickName: this.nickName,
    );
  }
}
