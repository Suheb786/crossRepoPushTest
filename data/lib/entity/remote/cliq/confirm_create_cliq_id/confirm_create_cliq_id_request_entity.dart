// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'confirm_create_cliq_id_request_entity.g.dart';

@JsonSerializable()
class ConfirmCreateCliqIdRequestEntity {
  @JsonKey(name: "accountNumber")
  final String? accountNumber;
  @JsonKey(name: "isAlias")
  final bool? isAlias;

  @JsonKey(name: "aliasValue")
  final String? aliasValue;

  @JsonKey(name: "otpCode")
  final String? otpCode;

  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseClass;

  ConfirmCreateCliqIdRequestEntity(
      {required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.otpCode,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$ConfirmCreateCliqIdRequestEntityToJson(this);

  factory ConfirmCreateCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCreateCliqIdRequestEntityFromJson(json);
}
