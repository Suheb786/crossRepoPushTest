import 'package:json_annotation/json_annotation.dart';

part "verify_forget_password_otp_request_entity.g.dart";

@JsonSerializable()
class VerifyForgetPasswordOtpRequestEntity {
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
  @JsonKey(name: "Otp")
  final String? otp;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  VerifyForgetPasswordOtpRequestEntity({
    required this.baseData,
    this.getToken= true,
    this.email,
    this.idExpiry,
    this.idNo,
    this.reEnterPassword,
    this.password,
    this.otp,
    this.uniqueId= "",
  });

  factory VerifyForgetPasswordOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyForgetPasswordOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyForgetPasswordOtpRequestEntityToJson(this);
}
