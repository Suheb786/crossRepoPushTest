import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_step_two_request_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardStepTwoRequestEntity {
  @JsonKey(name: "PrimaryCardId")
  final String? primaryCardId;
  @JsonKey(name: "SecondaryCardId")
  final String? secondaryCardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SupplementaryCreditCardStepTwoRequestEntity(
      {this.primaryCardId, this.secondaryCardId, this.getToken= false, required this.baseData});

  factory SupplementaryCreditCardStepTwoRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardStepTwoRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardStepTwoRequestEntityToJson(this);
}
