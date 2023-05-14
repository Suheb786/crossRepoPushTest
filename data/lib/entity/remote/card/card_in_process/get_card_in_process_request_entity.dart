import 'package:json_annotation/json_annotation.dart';

part 'get_card_in_process_request_entity.g.dart';

@JsonSerializable()
class GetCardInProcessRequestEntity {
  @JsonKey(name: "MinimumSettlement")
  final String? minimumSettlement;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "LoanValueId")
  final num? loanValueId;
  @JsonKey(name: "CreditLimit")
  final num? creditLimit;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetCardInProcessRequestEntity(
      {required this.baseData,
      this.getToken= true,
      this.minimumSettlement= "",
      this.loanValueId= 0,
      this.nickName= "",
      this.creditLimit= 0});

  factory GetCardInProcessRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCardInProcessRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCardInProcessRequestEntityToJson(this);
}
