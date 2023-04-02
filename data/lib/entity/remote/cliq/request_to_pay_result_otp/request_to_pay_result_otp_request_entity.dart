// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'request_to_pay_result_otp_request_entity.g.dart';

@JsonSerializable()
class RequestToPayResultOtpRequestEntity {
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  RequestToPayResultOtpRequestEntity({required this.getToken, required this.baseClass});

  Map<String, dynamic> toJson() => _$RequestToPayResultOtpRequestEntityToJson(this);

  factory RequestToPayResultOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayResultOtpRequestEntityFromJson(json);
}
