import 'package:json_annotation/json_annotation.dart';

part 'remove_customer_billing_request.g.dart';

@JsonSerializable()
class RemoveCustomerBillingRequest {
  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billingNo")
  final String? billingNo;

  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RemoveCustomerBillingRequest(
      {required this.billerCode,
      required this.billingNo,
      required this.serviceType,
      this.getToken: true,
      required this.baseData});

  factory RemoveCustomerBillingRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveCustomerBillingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCustomerBillingRequestToJson(this);
}
