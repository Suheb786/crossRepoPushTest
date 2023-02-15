// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'request_money_request_entity.g.dart';

@JsonSerializable()
class RequestMoneyRequestEntity {
  @JsonKey(name: "cliqType")
  final String? cliqType;
  @JsonKey(name: "iban")
  final String? iban;
  @JsonKey(name: "toAccountNo")
  final String? toAccountNo;
  @JsonKey(name: "alias")
  final String? alias;
  @JsonKey(name: "mobile")
  final String? mobile;
  @JsonKey(name: "receipentName")
  final String? receipentName;
  @JsonKey(name: "amount")
  final String? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "rtpPurposeCode")
  final String? rtpPurposeCode;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "beneficiaryId")
  final String? beneficiaryId;
  @JsonKey(name: "toAccountHolderName")
  final String? toAccountHolderName;
  @JsonKey(name: "receipentAddress")
  final String? receipentAddress;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseClass;

  RequestMoneyRequestEntity(
      {required this.cliqType,
      required this.iban,
      required this.toAccountNo,
      required this.alias,
      required this.mobile,
      required this.receipentName,
      required this.amount,
      required this.currency,
      required this.rtpPurposeCode,
      required this.description,
      required this.beneficiaryId,
      required this.toAccountHolderName,
      required this.receipentAddress,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$RequestMoneyRequestEntityToJson(this);

  factory RequestMoneyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestMoneyRequestEntityFromJson(json);
}
