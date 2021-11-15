import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "login_user_request.g.dart";

@JsonSerializable()
class LoginUserRequest {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  LoginUserRequest({this.email: "", this.password: "", required this.baseData});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
