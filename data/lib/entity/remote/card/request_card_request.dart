import 'package:json_annotation/json_annotation.dart';

part 'request_card_request.g.dart';

@JsonSerializable()
class RequestCardRequest {
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RequestCardRequest({
    required this.baseData,
    this.getToken: true,
    this.cardId: "",
  });

  factory RequestCardRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCardRequestToJson(this);
}
