import 'package:json_annotation/json_annotation.dart';

part 'cc_change_mobile_number_request_entity.g.dart';

@JsonSerializable()
class CcChangeMobileNumberRequestEntity {
  @JsonKey(name: "MobileCode")
  final String? mobileCode;
  @JsonKey(name: "MobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "OtpCode")
  final String? otpCode;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CcChangeMobileNumberRequestEntity(
      {required this.baseData,
      this.getToken: true,
      this.mobileCode,
      this.otpCode,
      this.mobileNumber,
      this.tokenizedPan});

  factory CcChangeMobileNumberRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CcChangeMobileNumberRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CcChangeMobileNumberRequestEntityToJson(this);
}
