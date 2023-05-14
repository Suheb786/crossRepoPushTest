import 'package:json_annotation/json_annotation.dart';

part "resend_otp_device_change_request_entity.g.dart";

@JsonSerializable()
class ResendOtpDeviceChangeRequestEntity {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ResendOtpDeviceChangeRequestEntity({
    required this.baseData,
    this.getToken= true,
    this.type= "DeviceChange",
  });

  factory ResendOtpDeviceChangeRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpDeviceChangeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpDeviceChangeRequestEntityToJson(this);
}
