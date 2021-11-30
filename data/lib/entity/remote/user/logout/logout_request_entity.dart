import 'package:json_annotation/json_annotation.dart';

part "logout_request_entity.g.dart";

@JsonSerializable()
class LogoutRequestEntity {
  @JsonKey(name: "IP")
  final String? iP;
  @JsonKey(name: "DeviceID")
  final String? deviceID;
  @JsonKey(name: "ChannelType")
  final String? channelType;
  @JsonKey(name: "Latitude")
  final String? latitude;
  @JsonKey(name: "Longitude")
  final String? longitude;
  @JsonKey(name: "Platform")
  final String? platform;
  @JsonKey(name: "Browser")
  final String? browser;
  @JsonKey(name: "VkeySessionId")
  final String? vkeySessionId;
  @JsonKey(name: "MobileModel")
  final String? mobileModel;
  @JsonKey(name: "AppVersion")
  final String? appVersion;

  LogoutRequestEntity(
      {this.appVersion,
      this.mobileModel,
      this.browser,
      this.platform,
      this.longitude,
      this.latitude,
      this.deviceID,
      this.vkeySessionId,
      this.channelType,
      this.iP});

  factory LogoutRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestEntityToJson(this);
}
