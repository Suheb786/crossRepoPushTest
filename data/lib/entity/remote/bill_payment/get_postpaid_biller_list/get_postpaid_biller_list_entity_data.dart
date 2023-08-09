import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_postpaid_biller_list_entity_data.g.dart';

@JsonSerializable()
class GetPostpaidBillerListEntityData
    extends BaseLayerDataTransformer<GetPostpaidBillerListEntityData, GetPostpaidBillerListModelData> {
  @JsonKey(name: "joebppsNo")
  final String? joebppsNo;

  @JsonKey(name: "customerId")
  final String? customerId;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billingNo")
  final String? billingNo;

  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "billingStatus")
  final String? billingStatus;

  @JsonKey(name: "nickName")
  final String? nickName;

  @JsonKey(name: "billerNameEN")
  final String? billerNameEN;

  @JsonKey(name: "billerNameAR")
  final String? billerNameAR;

  @JsonKey(name: "billerCatogaryEN")
  final String? billerCatogaryEN;

  @JsonKey(name: "billerCatogaryAR")
  final String? billerCatogaryAR;

  @JsonKey(name: "serviceTypeDescEN")
  final String? serviceTypeDescEN;

  @JsonKey(name: "serviceTypeAR")
  final String? serviceTypeAR;

  @JsonKey(name: "dueAmount")
  final String? dueAmount;

  @JsonKey(name: "dueDate")
  final String? dueDate;

  @JsonKey(name: "fees")
  final String? fees;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "iconCode")
  final dynamic iconCode;

  GetPostpaidBillerListEntityData({
    this.joebppsNo,
    this.customerId,
    this.billerCode,
    this.billingNo,
    this.serviceType,
    this.billingStatus,
    this.nickName,
    this.billerNameEN,
    this.billerNameAR,
    this.billerCatogaryEN,
    this.billerCatogaryAR,
    this.serviceTypeDescEN,
    this.serviceTypeAR,
    this.dueAmount,
    this.dueDate,
    this.fees,
    this.status,
    this.iconCode,
  });

  factory GetPostpaidBillerListEntityData.fromJson(Map<String, dynamic> json) =>
      _$GetPostpaidBillerListEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostpaidBillerListEntityDataToJson(this);

  @override
  GetPostpaidBillerListEntityData restore(GetPostpaidBillerListModelData data) {
    return GetPostpaidBillerListEntityData();
  }

  @override
  GetPostpaidBillerListModelData transform() {
    return GetPostpaidBillerListModelData(
      joebppsNo: this.joebppsNo ?? "",
      customerId: this.customerId ?? "",
      billerCode: this.billerCode ?? "",
      billingNo: this.billingNo ?? "",
      serviceType: this.serviceType ?? "",
      billingStatus: this.billingStatus ?? "",
      nickName: this.nickName ?? "",
      billerNameEN: this.billerNameEN ?? "",
      billerNameAR: this.billerNameAR ?? "",
      billerCatogaryEN: this.billerCatogaryEN ?? "",
      billerCatogaryAR: this.billerCatogaryAR ?? "",
      serviceTypeDescEN: this.serviceTypeDescEN ?? "",
      serviceTypeAR: this.serviceTypeAR ?? "",
      dueAmount: this.dueAmount ?? "0",
      actualdueAmountFromApi: this.dueAmount ?? "0",
      dueDate: this.dueDate ?? "0.0",
      fees: this.fees ?? "0.0",
      status: this.status,
      iconCode: this.iconCode?.toString() ?? "",
    );
  }
}
