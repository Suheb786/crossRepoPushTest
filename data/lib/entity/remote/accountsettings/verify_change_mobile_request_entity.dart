import 'package:json_annotation/json_annotation.dart';

part 'verify_change_mobile_request_entity.g.dart';

@JsonSerializable()
class VerifyChangeMobileRequestEntity {
  @JsonKey(name: "UniqueId")
  final String uniqueId;
  @JsonKey(name: "Otp")
  final String otp;
  @JsonKey(name: "MobileNo")
  final String mobileNo;
  @JsonKey(name: "MobileCode")
  final String mobileCode;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyChangeMobileRequestEntity(
      {this.uniqueId: "",
      this.otp: "",
      this.getToken: true,
      required this.baseData,
      required this.mobileNo,
      required this.mobileCode});

  factory VerifyChangeMobileRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyChangeMobileRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyChangeMobileRequestEntityToJson(this);
}
