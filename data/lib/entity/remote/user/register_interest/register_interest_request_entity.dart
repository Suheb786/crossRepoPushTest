import 'package:json_annotation/json_annotation.dart';

part "register_interest_request_entity.g.dart";

@JsonSerializable()
class RegisterInterestRequestEntity {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  RegisterInterestRequestEntity({this.uniqueId, required this.email, required this.baseData});

  factory RegisterInterestRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterInterestRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterInterestRequestEntityToJson(this);
}
