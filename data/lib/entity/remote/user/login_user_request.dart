import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "login_user_request.g.dart";

@JsonSerializable()
class LoginUserRequest {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "Platform")
  final String? platform;
  @JsonKey(name: "FireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  LoginUserRequest(
      {this.email: "",
      this.password: "",
      required this.baseData,
      this.getToken: true,
      this.platform: "",
      this.uniqueId: "",
      this.fireBaseToken: ""});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
