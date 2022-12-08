// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'get_alias_request_entity.g.dart';

@JsonSerializable()
class CliqGetAliasRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;
  CliqGetAliasRequestEntity({
    required this.getToken,
    required this.baseData,
  });
  factory CliqGetAliasRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CliqGetAliasRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CliqGetAliasRequestEntityToJson(this);
}
