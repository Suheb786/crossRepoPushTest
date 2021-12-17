import 'package:json_annotation/json_annotation.dart';

part 'check_agent_status_request_entity.g.dart';

@JsonSerializable()
class CheckAgentStatusRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckAgentStatusRequestEntity({this.getToken, required this.baseData});

  factory CheckAgentStatusRequestEntity.fromJson(
      Map<String, dynamic> json) =>
      _$CheckAgentStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckAgentStatusRequestEntityToJson(this);
}
