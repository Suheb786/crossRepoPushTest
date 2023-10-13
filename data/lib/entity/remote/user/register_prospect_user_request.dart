import 'package:json_annotation/json_annotation.dart';

part "register_prospect_user_request.g.dart";

@JsonSerializable()
class RegisterProspectUserRequest {
  @JsonKey(name: "CountryName")
  final String? countryName;
  @JsonKey(name: "LanguageCode")
  final String? languageCode;
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "CompanyId")
  final int? companyId;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "MobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "MobileCode")
  final String? mobileCode;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "ConfirmPassword")
  final String? confirmPassword;
  @JsonKey(name: "UserName")
  final String? userName;
  @JsonKey(name: "FireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "VkeySessionId")
  final String? vkeySessionId;
  @JsonKey(name: "Platform")
  final String? platform;

  @JsonKey(name: "RefferalPromo")
  final String? referralCode;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RegisterProspectUserRequest(
      {this.countryName,
      this.languageCode,
      this.uniqueId = "",
      this.companyId,
      this.email,
      this.mobileNumber,
      this.mobileCode,
      this.password,
      this.confirmPassword,
      this.userName,
      this.fireBaseToken,
      this.vkeySessionId,
      this.platform,
      this.referralCode,
      this.getToken,
      required this.baseData});

  factory RegisterProspectUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterProspectUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterProspectUserRequestToJson(this);
}
