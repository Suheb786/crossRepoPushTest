// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'get_alias_request_entity.g.dart';

@JsonSerializable()
class CliqGetAliasResponseEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;
  CliqGetAliasResponseEntity({
    required this.getToken,
    required this.baseData,
  });
factory CliqGetAliasResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CliqGetAliasResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CliqGetAliasResponseEntityToJson(this);
}
