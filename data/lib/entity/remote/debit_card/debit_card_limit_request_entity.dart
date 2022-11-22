import 'package:json_annotation/json_annotation.dart';

part 'debit_card_limit_request_entity.g.dart';

@JsonSerializable()
class DebitCardLimitRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  DebitCardLimitRequestEntity({this.getToken: true, this.baseData, this.tokenizedPan: ""});

  factory DebitCardLimitRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DebitCardLimitRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DebitCardLimitRequestEntityToJson(this);
}
