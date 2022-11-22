import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'base_class.g.dart';

@JsonSerializable()
class BaseClassEntity {
  @JsonKey(name: "IP")
  String? ip;
  @JsonKey(name: "DeviceID")
  String? deviceID;
  @JsonKey(name: "ChannelType")
  String? channelType;
  @JsonKey(name: "Latitude")
  String? latitude;
  @JsonKey(name: "Longitude")
  String? longitude;
  @JsonKey(name: "Platform")
  String? platform;
  @JsonKey(name: "Browser")
  String? browser;
  @JsonKey(name: "MobileModel")
  String? mobileModel;
  @JsonKey(name: "AppVersion")
  String? appVersion;
  @JsonKey(name: "VkeySessionId")
  String? vKeySessionId;

  BaseClassEntity(
      {this.ip,
      this.deviceID,
      channelType,
      this.latitude: "0.0",
      this.longitude: "0.0",
      platform,
      this.browser,
      this.mobileModel,
      this.appVersion,
      this.vKeySessionId: ""}) {
    this.platform = Platform.isAndroid
        ? "A"
        : Platform.isIOS
            ? "I"
            : "";
    this.channelType = "01";
  }

  factory BaseClassEntity.fromJson(Map<String, dynamic> json) => _$BaseClassEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseClassEntityToJson(this);
}
