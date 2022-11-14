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

  RemoveCustomerBillingRequest({
    required this.billerCode,
    required this.billingNo,
    required this.serviceType,
  });

  factory RemoveCustomerBillingRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveCustomerBillingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCustomerBillingRequestToJson(this);
}
