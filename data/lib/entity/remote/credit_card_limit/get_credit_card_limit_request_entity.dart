import 'package:json_annotation/json_annotation.dart';

part 'get_credit_card_limit_request_entity.g.dart';

@JsonSerializable()
class CreditCardLimitRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  CreditCardLimitRequestEntity({this.getToken= true, this.baseData, this.secureCode= ""});

  factory CreditCardLimitRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditCardLimitRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardLimitRequestEntityToJson(this);
}
