import 'package:json_annotation/json_annotation.dart';

part 'card_issuance_request.g.dart';

@JsonSerializable()
class CardIssuanceRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CardIssuanceRequest({required this.baseData, this.getToken: true});

  factory CardIssuanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CardIssuanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CardIssuanceRequestToJson(this);
}
