import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_prepaid_biller_list_entity_data.g.dart';

@JsonSerializable()
class GetPrepaidBillerListEntityData extends BaseLayerDataTransformer<
    GetPrepaidBillerListEntityData, GetPrepaidBillerListModelData> {

  @JsonKey(name: "billingNumber")
  final String? billingNumber;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billerName")
  final String? billerName;

  @JsonKey(name: "nickname")
  final String? nickname;

  @JsonKey(name: "registrationId")
  final String? registrationId;

  @JsonKey(name: "prepaidCategoryDescription")
  final String? prepaidCategoryDescription;

  @JsonKey(name: "prepaidCategoryCode")
  final String? prepaidCategoryCode;

  @JsonKey(name: "customerType")
  final String? customerType;

  @JsonKey(name: "joebppsNo")
  final String? joebppsNo;

  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "serviceCode")
  final String? serviceCode;

  @JsonKey(name: "iconCode")
  final String? iconCode;

  @JsonKey(name: "rimNo")
  final String? rimNo;

  GetPrepaidBillerListEntityData(
      {this.billingNumber,
      this.billerCode,
      this.billerName,
      this.nickname,
      this.registrationId,
      this.prepaidCategoryDescription,
      this.prepaidCategoryCode,
      this.customerType,
      this.joebppsNo,
      this.serviceType,
      this.serviceCode,
      this.iconCode,
      this.rimNo});

  factory GetPrepaidBillerListEntityData.fromJson(Map<String, dynamic> json) =>
      _$GetPrepaidBillerListEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrepaidBillerListEntityDataToJson(this);

  @override
  GetPrepaidBillerListEntityData restore(GetPrepaidBillerListModelData data) {
    return GetPrepaidBillerListEntityData();
  }


  @override
  GetPrepaidBillerListModelData transform() {
    return GetPrepaidBillerListModelData(
        billingNumber:this.billingNumber,
        billerCode: this.billerCode,
        billerName: this.billerName,
        nickname: this.nickname,
        registrationId: this.registrationId,
        prepaidCategoryDescription: this.prepaidCategoryDescription,
        prepaidCategoryCode: this.prepaidCategoryCode,
        customerType: this.customerType,
        joebppsNo: this.joebppsNo,
        serviceType: this.serviceType,
        serviceCode: this.serviceCode,
        iconCode: this.iconCode,
        rimNo: this.rimNo);
  }
}
