import 'package:json_annotation/json_annotation.dart';

part 'cancel_debit_card_request_entity.g.dart';

@JsonSerializable()
class CancelDebitCardRequestEntity {
  @JsonKey(name: "Status")
  final String? status;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CancelDebitCardRequestEntity({
    required this.baseData,
    this.getToken: true,
    this.status: "",
    this.tokenizedPan: "",
  });

  factory CancelDebitCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CancelDebitCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CancelDebitCardRequestEntityToJson(this);
}
