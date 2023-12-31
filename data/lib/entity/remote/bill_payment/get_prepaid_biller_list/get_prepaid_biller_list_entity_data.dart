import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_prepaid_biller_list_entity_data.g.dart';

@JsonSerializable()
class GetPrepaidBillerListEntityData
    extends BaseLayerDataTransformer<GetPrepaidBillerListEntityData, GetPrepaidBillerListModelData> {
  @JsonKey(name: "billingNo")
  final String? billingNumber;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billerNameAR")
  final String? billerNameAR;

  @JsonKey(name: "billerName")
  final String? billerName;

  @JsonKey(name: "nickName")
  final String? nickname;

  @JsonKey(name: "registrationID")
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

  @JsonKey(name: "serviceTypeAR")
  final String? serviceTypeAR;

  @JsonKey(name: "serviceCode")
  final String? serviceCode;

  @JsonKey(name: "iconCode")
  final dynamic iconCode;

  @JsonKey(name: "rimNo")
  final String? rimNo;

  GetPrepaidBillerListEntityData(
      {this.billingNumber,
      this.billerCode,
      this.billerName,
      this.billerNameAR,
      this.nickname,
      this.registrationId,
      this.prepaidCategoryDescription,
      this.prepaidCategoryCode,
      this.customerType,
      this.joebppsNo,
      this.serviceType,
      this.serviceTypeAR,
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
        billingNumber: this.billingNumber,
        billerCode: this.billerCode,
        billerName: this.billerName ?? "",
        billerNameAR: this.billerNameAR ?? "",
        nickname: this.nickname,
        registrationId: this.registrationId,
        prepaidCategoryDescription: this.prepaidCategoryDescription,
        prepaidCategoryCode: this.prepaidCategoryCode,
        customerType: this.customerType,
        joebppsNo: this.joebppsNo,
        serviceType: this.serviceType ?? "",
        serviceTypeAR: this.serviceTypeAR ?? "",
        serviceCode: this.serviceCode,
        iconCode: this.iconCode?.toString() ?? "",
        rimNo: this.rimNo);
  }
}
