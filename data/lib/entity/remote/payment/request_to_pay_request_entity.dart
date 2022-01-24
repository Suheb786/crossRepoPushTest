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
  @JsonKey(name: "Memo")
  final String? memo;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "BeneImage")
  final String? beneImage;
  @JsonKey(name: "IsFriend")
  final bool? isFriend;
  @JsonKey(name: "Type")
  final String? type;
  @JsonKey(name: "DetCustomerType")
  final String? detCustomerType;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  RequestToPayRequestEntity(
      {this.ctgyPurp,
      this.amount,
      this.dbtrBic,
      this.dbtrAcct,
      this.nickName: "",
      this.beneImage: "",
      this.isFriend: false,
      this.dbtrName,
      this.memo,
      this.getToken: true,
      this.baseData,
      this.type: "",
      this.detCustomerType: ""});

  factory RequestToPayRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayRequestEntityToJson(this);
}
