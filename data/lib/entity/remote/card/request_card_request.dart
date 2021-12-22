import 'package:json_annotation/json_annotation.dart';

part 'request_card_request.g.dart';

@JsonSerializable()
class RequestCardRequest {
  @JsonKey(name: "CardLimit")
  final double? cardLimit;
  @JsonKey(name: "AccountId")
  final String? accountId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  RequestCardRequest(
      {required this.baseData,
      this.getToken: true,
      this.cardLimit: 0.0,
      this.accountId: "1"});

  factory RequestCardRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCardRequestToJson(this);
}
