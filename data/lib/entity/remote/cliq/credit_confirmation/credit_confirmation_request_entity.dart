// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'credit_confirmation_request_entity.g.dart';

@JsonSerializable()
class CreditConfirmationRequestEntity {
  @JsonKey(name: "MsgId")
  final String msgId;

  @JsonKey(name: "CustID")
  final String custID;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  CreditConfirmationRequestEntity(
      {required this.getToken, required this.baseClass, required this.custID, required this.msgId});

  Map<String, dynamic> toJson() => _$CreditConfirmationRequestEntityToJson(this);

  factory CreditConfirmationRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditConfirmationRequestEntityFromJson(json);
}
