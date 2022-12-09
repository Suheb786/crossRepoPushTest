// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'get_customer_by_account_request_entity.g.dart';

@JsonSerializable()
class GetCustomByAccountRequestEntity {
  @JsonKey(name: "accountCode")
  final String? accountCode;
  @JsonKey(name: "CustID")
  final String? CustID;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  GetCustomByAccountRequestEntity(
      {required this.accountCode,
      required this.CustID,
      required this.GetToken,
      required this.BaseClass});

  Map<String, dynamic> toJson() =>
      _$GetCustomByAccountRequestEntityToJson(this);

  factory GetCustomByAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCustomByAccountRequestEntityFromJson(json);
}
