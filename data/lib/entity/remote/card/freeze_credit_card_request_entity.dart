import 'package:json_annotation/json_annotation.dart';

part 'freeze_credit_card_request_entity.g.dart';

@JsonSerializable()
class FreezeCreditCardRequestEntity {
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "IssuedFromCms")
  final bool? issuedFromCms;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  FreezeCreditCardRequestEntity(
      {required this.baseData,
      this.getToken = true,
      this.cardId = "",
      this.secureCode = '',
      this.issuedFromCms = false});

  factory FreezeCreditCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$FreezeCreditCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FreezeCreditCardRequestEntityToJson(this);
}
