import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "register_prospect_user_request.g.dart";

@JsonSerializable()
class RegisterProspectUserRequest {
  @JsonKey(name: "countryName")
  final String? countryName;
  @JsonKey(name: "languageCode")
  final String? languageCode;
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "companyId")
  final int? companyId;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "confirmPassword")
  final String? confirmPassword;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "fireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "vkeySessionId")
  final String? vkeySessionId;
  @JsonKey(name: "platform")
  final String? platform;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  RegisterProspectUserRequest(
      {this.countryName,
      this.languageCode,
      this.uniqueId: "",
      this.companyId,
      this.email,
      this.mobileNumber,
      this.password,
      this.confirmPassword,
      this.userName,
      this.fireBaseToken,
      this.vkeySessionId,
      this.platform,
      this.getToken,
      required this.baseData});

  factory RegisterProspectUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterProspectUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterProspectUserRequestToJson(this);
}
