import 'package:json_annotation/json_annotation.dart';

part "get_allowed_country_request_entity.g.dart";

@JsonSerializable()
class GetAllowedCountryRequestEntity {
  @JsonKey(name: "channelId")
  final String? channelId;
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetAllowedCountryRequestEntity({required this.baseData, this.content, this.channelId= "01"});

  factory GetAllowedCountryRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAllowedCountryRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllowedCountryRequestEntityToJson(this);
}
