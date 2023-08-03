import 'package:json_annotation/json_annotation.dart';

part 'unblock_debit_card_pin_request.g.dart';

@JsonSerializable()
class UnblockDebitCardPinRequest {
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UnblockDebitCardPinRequest({
    required this.baseData,
    this.getToken = true,
    this.tokenizedPan,
  });

  factory UnblockDebitCardPinRequest.fromJson(Map<String, dynamic> json) =>
      _$UnblockDebitCardPinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UnblockDebitCardPinRequestToJson(this);
}
