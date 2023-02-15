// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'request_money_activity_request_entity.g.dart';

@JsonSerializable()
class RequestMoneyActivityRequestEntity {
  @JsonKey(name: "FilterDays")
  final int FilterDays;
  @JsonKey(name: "TransactionType")
  final String TransactionType;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  RequestMoneyActivityRequestEntity(
      {required this.FilterDays,
      required this.TransactionType,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() =>
      _$RequestMoneyActivityRequestEntityToJson(this);

  factory RequestMoneyActivityRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$RequestMoneyActivityRequestEntityFromJson(json);
}
