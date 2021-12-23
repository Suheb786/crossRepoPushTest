import 'package:json_annotation/json_annotation.dart';

part "confirm_application_data_get_request_entity.g.dart";

@JsonSerializable()
class ConfirmApplicationDataGetRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ConfirmApplicationDataGetRequestEntity(
      {this.getToken, required this.baseData});

  factory ConfirmApplicationDataGetRequestEntity.fromJson(
      Map<String, dynamic> json) =>
      _$ConfirmApplicationDataGetRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmApplicationDataGetRequestEntityToJson(this);
}
