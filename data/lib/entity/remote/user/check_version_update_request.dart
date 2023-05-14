import 'package:json_annotation/json_annotation.dart';

part "check_version_update_request.g.dart";

@JsonSerializable()
class CheckVersionUpdateRequest {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "Platform")
  final String? platform;
  @JsonKey(name: "Clear")
  final String? clear;
  @JsonKey(name: "ParentVersion")
  final String? parentVersion;
  @JsonKey(name: "Version")
  final String? version;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckVersionUpdateRequest(
      {this.uniqueId,
      this.platform,
      this.clear= "true",
      this.parentVersion,
      this.version,
      required this.baseData});

  factory CheckVersionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckVersionUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckVersionUpdateRequestToJson(this);
}
