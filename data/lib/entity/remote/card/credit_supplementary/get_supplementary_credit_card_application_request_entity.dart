import 'package:json_annotation/json_annotation.dart';

part "get_supplementary_credit_card_application_request_entity.g.dart";

@JsonSerializable()
class GetSupplementaryCreditCardApplicationRequestEntity {
  @JsonKey(name: "PrimaryCard")
  final String? primaryCard;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetSupplementaryCreditCardApplicationRequestEntity(
      {this.primaryCard, this.getToken = false, required this.baseData});

  factory GetSupplementaryCreditCardApplicationRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSupplementaryCreditCardApplicationRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetSupplementaryCreditCardApplicationRequestEntityToJson(this);
}
