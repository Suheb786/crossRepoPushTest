import 'package:json_annotation/json_annotation.dart';

part "send_money_to_cliq_iban_request_entity.g.dart";

@JsonSerializable()
class SendMoneyToCliqIbanRequestEntity {
  @JsonKey(name: "otpCode")
  final String? otpCode;

  @JsonKey(name: "transferType")
  final String? transferType;

  @JsonKey(name: "cliqType")
  final String? cliqType;

  @JsonKey(name: "toIban")
  final String? toIban;

  @JsonKey(name: "toAccountNo")
  final String? toAccountNo;

  @JsonKey(name: "toAlias")
  final String? toAlias;

  @JsonKey(name: "toMobileNo")
  final String? toMobileNo;

  @JsonKey(name: "toBankCountry")
  final String? toBankCountry;

  @JsonKey(name: "swift")
  final String? swift;

  @JsonKey(name: "routingNO")
  final String? routingNO;

  @JsonKey(name: "recipientName")
  final String? recipientName;

  @JsonKey(name: "fromAccountNo")
  final String? fromAccountNo;

  @JsonKey(name: "transferAmount")
  final String? transferAmount;

  @JsonKey(name: "fromAccountCurrency")
  final String? fromAccountCurrency;

  @JsonKey(name: "toAccountCurrency")
  final String? toAccountCurrency;

  @JsonKey(name: "Charges")
  final bool? Charges;

  @JsonKey(name: "TransferPurposeCode")
  final String? TransferPurposeCode;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "whenToSend")
  final String? whenToSend;

  @JsonKey(name: "beneficiaryId")
  final String? beneficiaryId;

  @JsonKey(name: "fromCardId")
  final dynamic fromCardId;

  @JsonKey(name: "fromCardType")
  final dynamic fromCardType;

  @JsonKey(name: "ownAccountTransferType")
  final dynamic ownAccountTransferType;

  @JsonKey(name: "fromAccountHolderName")
  final String? fromAccountHolderName;

  @JsonKey(name: "recipientAddress")
  final String? recipientAddress;

  @JsonKey(name: "flagAmount")
  final String? flagAmount;

  @JsonKey(name: "flagCurrency")
  final String? flagCurrency;

  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SendMoneyToCliqIbanRequestEntity(
      {required this.otpCode,
      required this.transferType,
      required this.cliqType,
      required this.toIban,
      required this.toAccountNo,
      required this.toAlias,
      required this.toMobileNo,
      required this.toBankCountry,
      required this.swift,
      required this.routingNO,
      required this.recipientName,
      required this.fromAccountNo,
      required this.transferAmount,
      required this.fromAccountCurrency,
      required this.toAccountCurrency,
      required this.Charges,
      required this.TransferPurposeCode,
      required this.description,
      required this.whenToSend,
      required this.beneficiaryId,
      this.fromCardId,
      this.fromCardType,
      this.ownAccountTransferType,
      required this.fromAccountHolderName,
      required this.recipientAddress,
      required this.flagAmount,
      required this.flagCurrency,
      required this.getToken,
      required this.baseData});

  factory SendMoneyToCliqIbanRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SendMoneyToCliqIbanRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendMoneyToCliqIbanRequestEntityToJson(this);
}
