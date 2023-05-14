import 'package:json_annotation/json_annotation.dart';

part 'check_videocall_status_request_entity.g.dart';

@JsonSerializable()
class CheckVideoCallStatusRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckVideoCallStatusRequestEntity({this.getToken= true, required this.baseData});

  factory CheckVideoCallStatusRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckVideoCallStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckVideoCallStatusRequestEntityToJson(this);
}
