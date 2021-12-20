import 'package:json_annotation/json_annotation.dart';

part 'confirm_creditcard_delivery_request.g.dart';

@JsonSerializable()
class ConfirmCreditCardDeliveryRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "AccountId")
  final int? accountId;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ConfirmCreditCardDeliveryRequest(
      {required this.baseData, this.getToken: true, this.accountId: 1});

  factory ConfirmCreditCardDeliveryRequest.fromJson(
          Map<String, dynamic> json) =>
      _$ConfirmCreditCardDeliveryRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmCreditCardDeliveryRequestToJson(this);
}
