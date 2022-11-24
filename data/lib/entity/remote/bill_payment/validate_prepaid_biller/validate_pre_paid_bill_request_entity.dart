import 'package:json_annotation/json_annotation.dart';

part 'validate_pre_paid_bill_request_entity.g.dart';

@JsonSerializable()
class ValidatePrePaidBillRequestEntity {
  @JsonKey(name: "billerCode")
  String? billerCode;
  @JsonKey(name: "amount")
  String? amount;
  @JsonKey(name: "serviceType")
  String? serviceType;
  @JsonKey(name: "billingNumber")
  String? billingNumber;
  @JsonKey(name: "prepaidCategoryCode")
  String? prepaidCategoryCode;
  @JsonKey(name: "prepaidCategoryType")
  String? prepaidCategoryType;
  @JsonKey(name: "billingNumberRequired")
  bool? billingNumberRequired;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;


  ValidatePrePaidBillRequestEntity({
    this.billerCode,
    this.amount,
    this.serviceType,
    this.billingNumber,
    this.prepaidCategoryCode,
    this.prepaidCategoryType,
    this.billingNumberRequired,
    this.getToken,
    required this.baseData,
  });

  factory ValidatePrePaidBillRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$ValidatePrePaidBillRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ValidatePrePaidBillRequestEntityToJson(this);
}
