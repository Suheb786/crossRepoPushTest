import 'package:json_annotation/json_annotation.dart';

part 'dc_change_mobile_number_request_entity.g.dart';

@JsonSerializable()
class DcChangeMobileNumberRequestEntity {
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

  DcChangeMobileNumberRequestEntity(
      {required this.baseData,
      this.getToken: true,
      this.mobileCode,
      this.otpCode,
      this.mobileNumber,
      this.tokenizedPan});

  factory DcChangeMobileNumberRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$DcChangeMobileNumberRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DcChangeMobileNumberRequestEntityToJson(this);
}
