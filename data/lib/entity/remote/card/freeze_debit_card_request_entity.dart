import 'package:json_annotation/json_annotation.dart';

part 'freeze_debit_card_request_entity.g.dart';

@JsonSerializable()
class FreezeDebitCardRequestEntity {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  FreezeDebitCardRequestEntity({
    required this.baseData,
    this.getToken: true,
    this.status: "",
    this.tokenizedPan: "",
  });

  factory FreezeDebitCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$FreezeDebitCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FreezeDebitCardRequestEntityToJson(this);
}
