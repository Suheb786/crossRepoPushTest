import 'package:json_annotation/json_annotation.dart';

part "kyc_status_request.g.dart";

@JsonSerializable()
class KYCStatusRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  KYCStatusRequest({required this.baseData, this.getToken = true});

  factory KYCStatusRequest.fromJson(Map<String, dynamic> json) => _$KYCStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KYCStatusRequestToJson(this);
}
