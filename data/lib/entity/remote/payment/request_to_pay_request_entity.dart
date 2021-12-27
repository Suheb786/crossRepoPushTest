import 'package:json_annotation/json_annotation.dart';

part "request_to_pay_request_entity.g.dart";

@JsonSerializable()
class RequestToPayRequestEntity {
  @JsonKey(name: "CtgyPurp")
  final String? ctgyPurp;
  @JsonKey(name: "Amount")
  final num? amount;
  @JsonKey(name: "DbtrBic")
  final String? dbtrBic;
  @JsonKey(name: "DbtrAcct")
  final String? dbtrAcct;
  @JsonKey(name: "DbtrName")
  final String? dbtrName;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  RequestToPayRequestEntity(
      {this.ctgyPurp,
      this.amount,
      this.dbtrBic,
      this.dbtrAcct,
      this.dbtrName,
      this.getToken,
      this.baseData});

  factory RequestToPayRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayRequestEntityToJson(this);
}
