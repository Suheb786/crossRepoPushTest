import 'package:json_annotation/json_annotation.dart';

part "get_credit_card_relationship_request_entity.g.dart";

@JsonSerializable()
class GetCreditCardRelationshipRequestEntity {
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetCreditCardRelationshipRequestEntity({this.cardId, this.getToken: false, required this.baseData});

  factory GetCreditCardRelationshipRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCreditCardRelationshipRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditCardRelationshipRequestEntityToJson(this);
}
