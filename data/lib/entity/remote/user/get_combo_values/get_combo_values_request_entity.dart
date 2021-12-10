import 'package:json_annotation/json_annotation.dart';

part "get_combo_values_request_entity.g.dart";

@JsonSerializable()
class GetComboValuesRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetComboValuesRequestEntity(
      {this.getToken, required this.baseData});

  factory GetComboValuesRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetComboValuesRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetComboValuesRequestEntityToJson(this);
}
