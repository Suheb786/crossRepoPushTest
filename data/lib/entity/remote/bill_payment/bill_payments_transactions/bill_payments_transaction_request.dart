import 'package:json_annotation/json_annotation.dart';

part "bill_payments_transaction_request.g.dart";

@JsonSerializable()
class BillPaymentsTransactionRequest {
  @JsonKey(name: "PageSize")
  final num? pageSize;

  @JsonKey(name: "PageNo")
  final num? pageNo;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  BillPaymentsTransactionRequest({
    this.pageSize,
    this.pageNo,
    this.type,
    this.getToken,
    required this.baseData,
  });

  factory BillPaymentsTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentsTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BillPaymentsTransactionRequestToJson(this);
}
