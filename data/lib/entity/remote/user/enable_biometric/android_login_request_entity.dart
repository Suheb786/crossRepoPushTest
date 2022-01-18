import 'package:json_annotation/json_annotation.dart';

part "android_login_request_entity.g.dart";

@JsonSerializable()
class AndroidLoginRequestEntity {
  @JsonKey(name: "uniqueId")
  final String? uniqueId;
  @JsonKey(name: "fireBaseToken")
  final String? fireBaseToken;
  @JsonKey(name: "Signature")
  final String? signature;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  AndroidLoginRequestEntity(
      {this.uniqueId: "",
      required this.baseData,
      this.fireBaseToken: "",
      this.signature: ""});

  factory AndroidLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AndroidLoginRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AndroidLoginRequestEntityToJson(this);
}
