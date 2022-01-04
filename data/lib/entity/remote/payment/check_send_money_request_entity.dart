import 'package:json_annotation/json_annotation.dart';

part "check_send_money_request_entity.g.dart";

@JsonSerializable()
class CheckSendMoneyRequestEntity {
  @JsonKey(name: "ToAccount")
  final String? toAccount;
  @JsonKey(name: "ToAmount")
  final num? toAmount;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckSendMoneyRequestEntity(
      {required this.baseData, this.toAccount:'', this.toAmount:0, this.getToken: true});

  factory CheckSendMoneyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckSendMoneyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckSendMoneyRequestEntityToJson(this);
}
