import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_user_email_request.g.dart";

@JsonSerializable()
class CheckUserEmailRequest {
  @JsonKey(name: "userName")
  final String? email;
  @JsonKey(name: "channelId")
  final String? channelId;
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  CheckUserEmailRequest(
      {this.email: "",
      this.channelId: "01",
      this.uniqueId: "",
      required this.baseData});

  factory CheckUserEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUserEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserEmailRequestToJson(this);
}
