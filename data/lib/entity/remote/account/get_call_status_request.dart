import 'package:json_annotation/json_annotation.dart';

part 'get_call_status_request.g.dart';

@JsonSerializable()
class GetCallStatusRequest {
  @JsonKey(name: "session")
  final String? session;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetCallStatusRequest({this.session= "", required this.baseData});

  factory GetCallStatusRequest.fromJson(Map<String, dynamic> json) => _$GetCallStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetCallStatusRequestToJson(this);
}
