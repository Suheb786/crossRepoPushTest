import 'package:json_annotation/json_annotation.dart';

part 'request_video_call_request.g.dart';

@JsonSerializable()
class RequestVideoCallRequest {
  @JsonKey(name: "Gender")
  final String? gender;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RequestVideoCallRequest({
    this.gender: "",
    required this.baseData,
  });

  factory RequestVideoCallRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestVideoCallRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestVideoCallRequestToJson(this);
}
