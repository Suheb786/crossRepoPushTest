import 'package:json_annotation/json_annotation.dart';

part 'link_card_step_request_entity.g.dart';

@JsonSerializable()
class LinkCardStepRequestEntity {
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "AccountNumber")
  final String? accountNumber;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  LinkCardStepRequestEntity(
      {required this.baseData, this.getToken= true, this.cardId= "", this.accountNumber= ""});

  factory LinkCardStepRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LinkCardStepRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LinkCardStepRequestEntityToJson(this);
}
