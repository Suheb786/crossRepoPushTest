// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'create_cliq_id_request_entity.g.dart';

@JsonSerializable()
class CreateCliqIdRequestEntity {
  @JsonKey(name: "accountNumber")
  final String? accountNumber;
  @JsonKey(name: "isAlias")
  final bool? isAlias;

  @JsonKey(name: "aliasValue")
  final String? aliasValue;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseClass;

  CreateCliqIdRequestEntity(
      {required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$CreateCliqIdRequestEntityToJson(this);

  factory CreateCliqIdRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateCliqIdRequestEntityFromJson(json);
}
