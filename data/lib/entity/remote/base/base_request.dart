import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable()
class BaseRequest {
  @JsonKey(name: "GetToken")
  bool? getToken;
  @JsonKey(name: "baseClass")
  Map<String, dynamic>? baseData;

  BaseRequest({this.getToken: true, required this.baseData});

  factory BaseRequest.fromJson(Map<String, dynamic> json) =>
      _$BaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
}
