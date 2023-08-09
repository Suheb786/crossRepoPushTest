import 'package:json_annotation/json_annotation.dart';

part "send_otp_token_device_change_request_entity.g.dart";

@JsonSerializable()
class SendOtpTokenDeviceChangeRequestEntity {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "otp")
  final String? otp;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SendOtpTokenDeviceChangeRequestEntity(
      {required this.baseData, this.getToken = true, this.type = "DeviceChange", this.otp = ""});

  factory SendOtpTokenDeviceChangeRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOtpTokenDeviceChangeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpTokenDeviceChangeRequestEntityToJson(this);
}
