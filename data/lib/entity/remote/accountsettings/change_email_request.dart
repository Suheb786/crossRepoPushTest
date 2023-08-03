import 'package:json_annotation/json_annotation.dart';

part 'change_email_request.g.dart';

@JsonSerializable()
class ChangeEmailRequest {
  @JsonKey(name: "EmailId")
  final String email;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ChangeEmailRequest({this.email = "", this.getToken = true, required this.baseData});

  factory ChangeEmailRequest.fromJson(Map<String, dynamic> json) => _$ChangeEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEmailRequestToJson(this);
}
