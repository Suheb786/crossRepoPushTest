import 'package:json_annotation/json_annotation.dart';

part "login_user_request.g.dart";

@JsonSerializable()
class LoginUserRequest {
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "platform")
  final String? platform;
  @JsonKey(name: "fireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  LoginUserRequest(
      {this.userName: "",
      this.password: "",
      required this.baseData,
      this.getToken: true,
      this.platform: "",
      this.uniqueId: "",
      this.fireBaseToken: ""});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
