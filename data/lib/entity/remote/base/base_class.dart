import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'base_class.g.dart';

@JsonSerializable()
class BaseClassEntity {
  @JsonKey(name: "ip")
  String? ip;
  @JsonKey(name: "deviceID")
  String? deviceID;
  @JsonKey(name: "channelType")
  String? channelType;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "platform")
  String? platform;
  @JsonKey(name: "browser")
  String? browser;
  @JsonKey(name: "mobileModel")
  String? mobileModel;
  @JsonKey(name: "appVersion")
  String? appVersion;

  BaseClassEntity(
      {this.ip,
      this.deviceID,
      channelType,
      this.latitude: "0.0",
      this.longitude: "0.0",
      platform,
      this.browser,
      this.mobileModel,
      this.appVersion}) {
    this.platform = Platform.isAndroid ? "A" : "I";
    this.channelType = "App";
  }

  factory BaseClassEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseClassEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseClassEntityToJson(this);
}
