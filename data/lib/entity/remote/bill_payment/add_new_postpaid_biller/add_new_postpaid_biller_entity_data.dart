import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_new_postpaid_biller_entity_data.g.dart';

@JsonSerializable()
class AddNewPostpaidBillerEntityData extends BaseLayerDataTransformer<
    AddNewPostpaidBillerEntityData, AddNewPostpaidBillerModelData> {
  @JsonKey(name: "joebppsNo")
  String? joebppsNo;

  @JsonKey(name: "billerCode")
  String? billerCode;

  @JsonKey(name: "billingNo")
  String? billingNo;

  @JsonKey(name: "serviceType")
  String? serviceType;

  @JsonKey(name: "nickName")
  String? nickName;

  AddNewPostpaidBillerEntityData(
      {this.joebppsNo,
      this.billerCode,
      this.billingNo,
      this.serviceType,
      this.nickName});

  factory AddNewPostpaidBillerEntityData.fromJson(Map<String, dynamic> json) =>
      _$AddNewPostpaidBillerEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewPostpaidBillerEntityDataToJson(this);

  @override
  AddNewPostpaidBillerEntityData restore(AddNewPostpaidBillerModelData data) {
    return AddNewPostpaidBillerEntityData(
        joebppsNo: data.joebppsNo,
        billerCode: data.billerCode
    );
  }

  @override
  AddNewPostpaidBillerModelData transform() {
    return AddNewPostpaidBillerModelData(
        joebppsNo: this.joebppsNo,
        billerCode: this.billerCode,
        billingNo: this.billingNo,
        serviceType: this.serviceType,
        nickName: this.nickName);
  }
}
