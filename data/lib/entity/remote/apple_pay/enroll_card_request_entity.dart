import 'package:json_annotation/json_annotation.dart';

part "enroll_card_request_entity.g.dart";

@JsonSerializable()
class EnrollCardRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "walletId")
  final String? walletId;
  @JsonKey(name: "cardId")
  final String? cardId;
  @JsonKey(name: "cardType")
  final String? cardType;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  EnrollCardRequestEntity(
      {this.getToken = true, this.walletId = "", this.cardId = "", this.cardType, required this.baseData});

  factory EnrollCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EnrollCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollCardRequestEntityToJson(this);
}
