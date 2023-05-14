import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: "Password")
  final String currentPassword;
  @JsonKey(name: "NewPassword")
  final String newPassword;
  @JsonKey(name: "ConfirmPassword")
  final String confirmPassword;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ChangePasswordRequest(
      {this.currentPassword= "",
      this.newPassword= "",
      this.confirmPassword= "",
      this.getToken= true,
      required this.baseData});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
