import 'package:json_annotation/json_annotation.dart';

part "country_list_request_entity.g.dart";

@JsonSerializable()
class CountryListRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CountryListRequestEntity({required this.baseData, this.getToken: true});

  factory CountryListRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryListRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListRequestEntityToJson(this);
}
