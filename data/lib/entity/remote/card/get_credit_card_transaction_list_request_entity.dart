import 'package:json_annotation/json_annotation.dart';

part 'get_credit_card_transaction_list_request_entity.g.dart';

@JsonSerializable()
class GetCreditCardTransactionListRequestEntity {
  @JsonKey(name: "CardId")
  final String? cardId;
  @JsonKey(name: "NoOfDays")
  final num? noOfDays;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "SecureCode")
  final String? secureCode;
  @JsonKey(name: "IssuedFromCms")
  final bool? issuedFromCms;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetCreditCardTransactionListRequestEntity(
      {required this.baseData,
      this.getToken = true,
      this.noOfDays = 180,
      this.cardId = "",
      this.issuedFromCms = false,
      this.secureCode = ''});

  factory GetCreditCardTransactionListRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCreditCardTransactionListRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditCardTransactionListRequestEntityToJson(this);
}
