import 'package:json_annotation/json_annotation.dart';

part "check_forget_password_request_entity.g.dart";

@JsonSerializable()
class CheckForgetPasswordRequestEntity {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "Idno")
  final String? idNo;
  @JsonKey(name: "IdExpiry")
  final String? idExpiry;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CheckForgetPasswordRequestEntity({
    required this.baseData,
    this.getToken: true,
    this.email,
    this.idExpiry,
    this.idNo,
    this.uniqueId: "",
  });

  factory CheckForgetPasswordRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckForgetPasswordRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckForgetPasswordRequestEntityToJson(this);
}
