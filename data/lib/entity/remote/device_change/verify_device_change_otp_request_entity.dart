import 'package:json_annotation/json_annotation.dart';

part "verify_device_change_otp_request_entity.g.dart";

@JsonSerializable()
class VerifyDeviceChangeOtpRequestEntity {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "FireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "otp")
  final String? otp;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyDeviceChangeOtpRequestEntity(
      {required this.baseData,
      this.getToken= true,
      this.type= "DeviceChange",
      this.otp= "",
      this.fireBaseToken= ""});

  factory VerifyDeviceChangeOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyDeviceChangeOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDeviceChangeOtpRequestEntityToJson(this);
}
