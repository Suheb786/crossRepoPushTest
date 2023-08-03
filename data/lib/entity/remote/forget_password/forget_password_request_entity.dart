import 'package:json_annotation/json_annotation.dart';

part "forget_password_request_entity.g.dart";

@JsonSerializable()
class ForgetPasswordRequestEntity {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "Idno")
  final String? idNo;
  @JsonKey(name: "IdExpiry")
  final String? idExpiry;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "ReEnterPassword")
  final String? reEnterPassword;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ForgetPasswordRequestEntity({
    required this.baseData,
    this.getToken = true,
    this.email,
    this.idExpiry,
    this.idNo,
    this.password,
    this.reEnterPassword,
    this.uniqueId = "",
  });

  factory ForgetPasswordRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestEntityToJson(this);
}
