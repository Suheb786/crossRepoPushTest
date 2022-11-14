import 'package:json_annotation/json_annotation.dart';

part "add_new_postpaid_biller_entity_request.g.dart";


@JsonSerializable()
class AddNewPostpaidBillerEntityRequest {
  @JsonKey(name: "serviceType")
  final String? serviceType;

  @JsonKey(name: "billerCode")
  final String? billerCode;

  @JsonKey(name: "billingNumber")
  final String? billingNumber;

  @JsonKey(name: "nickname")
  final String? nickname;

  AddNewPostpaidBillerEntityRequest({
    this.serviceType,
    this.billerCode,
    this.billingNumber,
    this.nickname
  });

  factory AddNewPostpaidBillerEntityRequest.fromJson(Map<String, dynamic> json) =>
      _$AddNewPostpaidBillerEntityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewPostpaidBillerEntityRequestToJson(this);
}
