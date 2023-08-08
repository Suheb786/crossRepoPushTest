// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'edit_cliq_id_otp_request_entity.g.dart';

@JsonSerializable()
class EditCliqOtpRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;
  @JsonKey(name: "isAlias")
  final bool? isAlias;
  @JsonKey(name: "aliasValue")
  final String? aliasValue;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseClass;

  EditCliqOtpRequestEntity(
      {required this.aliasId,
      required this.isAlias,
      required this.aliasValue,
      required this.GetToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$EditCliqOtpRequestEntityToJson(this);

  factory EditCliqOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EditCliqOtpRequestEntityFromJson(json);
}
