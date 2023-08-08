import 'package:json_annotation/json_annotation.dart';

part 'verify_change_email_request.g.dart';

@JsonSerializable()
class VerifyChangeEmailRequest {
  @JsonKey(name: "UniqueId")
  final String uniqueId;
  @JsonKey(name: "Otp")
  final String otp;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyChangeEmailRequest({this.uniqueId = "", this.otp = "", this.getToken = true, required this.baseData});

  factory VerifyChangeEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyChangeEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyChangeEmailRequestToJson(this);
}
