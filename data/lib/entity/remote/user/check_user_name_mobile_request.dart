import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_user_name_mobile_request.g.dart";

@JsonSerializable()
class CheckUserNameMobileRequest {
  @JsonKey(name: "channelId")
  final String? channelId;
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

  CheckUserNameMobileRequest({this.channelId: "01", required this.content});

  factory CheckUserNameMobileRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUserNameMobileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserNameMobileRequestToJson(this);
}
