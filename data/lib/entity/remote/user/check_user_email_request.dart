import 'package:json_annotation/json_annotation.dart';

part "check_user_email_request.g.dart";

@JsonSerializable()
class CheckUserEmailRequest {
  @JsonKey(name: "channelId")
  final String? channelId;
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckUserEmailRequest({this.channelId = "01", required this.content, required this.baseData});

  factory CheckUserEmailRequest.fromJson(Map<String, dynamic> json) => _$CheckUserEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserEmailRequestToJson(this);
}
