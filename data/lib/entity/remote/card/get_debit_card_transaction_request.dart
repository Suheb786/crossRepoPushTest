import 'package:json_annotation/json_annotation.dart';

part 'get_debit_card_transaction_request.g.dart';

@JsonSerializable()
class GetDebitCardTransactionRequest {
  @JsonKey(name: "AccountNo")
  final String? accountNo;
  @JsonKey(name: "IsDebit")
  final bool? isDebit;
  @JsonKey(name: "NoOfDays")
  final num? noOfDays;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetDebitCardTransactionRequest({
    required this.baseData,
    this.noOfDays = 90,
    this.getToken = true,
    this.isDebit = true,
    this.accountNo,
  });

  factory GetDebitCardTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$GetDebitCardTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetDebitCardTransactionRequestToJson(this);
}
