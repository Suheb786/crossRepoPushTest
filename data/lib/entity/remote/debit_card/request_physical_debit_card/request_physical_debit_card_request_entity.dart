import 'package:json_annotation/json_annotation.dart';

part 'request_physical_debit_card_request_entity.g.dart';

@JsonSerializable()
class RequestPhysicalDebitCardRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  RequestPhysicalDebitCardRequestEntity({this.getToken= true, this.baseData, this.tokenizedPan= ""});

  factory RequestPhysicalDebitCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestPhysicalDebitCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestPhysicalDebitCardRequestEntityToJson(this);
}
