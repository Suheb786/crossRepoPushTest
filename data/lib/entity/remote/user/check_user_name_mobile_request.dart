import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_user_name_mobile_request.g.dart";

@JsonSerializable()
class CheckUserNameMobileRequest {
  @JsonKey(name: "channelId")
  final String? channelId;
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "countryCode")
  final String? countryCode;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  CheckUserNameMobileRequest(
      {this.channelId: "01",
      this.uniqueId: "",
      this.mobileNumber,
      this.countryCode,
      required this.baseData});

  factory CheckUserNameMobileRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUserNameMobileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserNameMobileRequestToJson(this);
}
