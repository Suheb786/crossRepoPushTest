import 'package:json_annotation/json_annotation.dart';

part "city_list_request_entity.g.dart";

@JsonSerializable()
class CityListRequestEntity {
  @JsonKey(name: "StateID")
  final String? stateID;
  @JsonKey(name: "IsoCode")
  final String? isoCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CityListRequestEntity({required this.baseData, this.getToken = true, this.isoCode = "", this.stateID = ""});

  factory CityListRequestEntity.fromJson(Map<String, dynamic> json) => _$CityListRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CityListRequestEntityToJson(this);
}
