import 'package:json_annotation/json_annotation.dart';

part "state_list_request_entity.g.dart";

@JsonSerializable()
class StateListRequestEntity {
  @JsonKey(name: "IsoCode")
  final String? isoCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  StateListRequestEntity(
      {required this.baseData, this.getToken: true, this.isoCode: ""});

  factory StateListRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$StateListRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StateListRequestEntityToJson(this);
}
