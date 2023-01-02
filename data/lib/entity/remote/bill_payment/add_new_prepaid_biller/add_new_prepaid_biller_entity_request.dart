import 'package:json_annotation/json_annotation.dart';

part "add_new_prepaid_biller_entity_request.g.dart";

@JsonSerializable()
class AddNewPrepaidBillerEntityRequest {
  @JsonKey(name: "prepaidCategoryType")
  final String? prepaidCategoryType;

  @JsonKey(name: "prepaidCategoryCode")
  final String? prepaidCategoryCode;

  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "serviceCode")
  final String? serviceCode;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billerName")
  final String? billerName;

  @JsonKey(name: "billingNumber")
  final String? billingNumber;

  @JsonKey(name: "nickname")
  final String? nickname;

  @JsonKey(name: "amount")
  final String? amount;

  @JsonKey(name: "billingNumberRequired")
  final bool? billingNumberRequired;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  AddNewPrepaidBillerEntityRequest({
    this.prepaidCategoryType,
    this.prepaidCategoryCode,
    this.serviceType,
    this.serviceCode,
    this.billerCode,
    this.billerName,
    this.billingNumber,
    this.nickname,
    this.amount,
    this.billingNumberRequired,
    this.getToken,
    required this.baseData,
  });

  factory AddNewPrepaidBillerEntityRequest.fromJson(
          Map<String, dynamic> json) =>
      _$AddNewPrepaidBillerEntityRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddNewPrepaidBillerEntityRequestToJson(this);
}
