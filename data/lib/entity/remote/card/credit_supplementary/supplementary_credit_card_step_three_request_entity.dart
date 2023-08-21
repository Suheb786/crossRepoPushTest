import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_step_three_request_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardStepThreeRequestEntity {
  @JsonKey(name: "PrimaryCardId")
  final String? primaryCardId;
  @JsonKey(name: "SecondaryCardId")
  final String? secondaryCardId;
  @JsonKey(name: "AccountNumber")
  final String? accountNumber;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SupplementaryCreditCardStepThreeRequestEntity(
      {this.primaryCardId,
      this.secondaryCardId,
      this.accountNumber,
      this.getToken = false,
      required this.baseData});

  factory SupplementaryCreditCardStepThreeRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardStepThreeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardStepThreeRequestEntityToJson(this);
}
