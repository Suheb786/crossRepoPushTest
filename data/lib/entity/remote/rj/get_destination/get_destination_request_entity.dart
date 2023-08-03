import 'package:json_annotation/json_annotation.dart';

part "get_destination_request_entity.g.dart";

@JsonSerializable()
class GetDestinationRequestEntity {
  @JsonKey(name: "Language")
  final String? language;
  @JsonKey(name: "Service")
  final String? service;
  @JsonKey(name: "Origin")
  final String? origin;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetDestinationRequestEntity(
      {required this.baseData, this.getToken = true, this.language, this.origin, this.service});

  factory GetDestinationRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetDestinationRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetDestinationRequestEntityToJson(this);
}
