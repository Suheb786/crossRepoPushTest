import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_payments_transaction_response.g.dart';

@JsonSerializable()
class BillPaymentsTransactionResponse
    extends BaseLayerDataTransformer<BillPaymentsTransactionResponse, BillPaymentsTransactionModel> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  BillPaymentsTransactionResponse({
    this.response,
  });

  factory BillPaymentsTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentsTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BillPaymentsTransactionResponseToJson(this);

  @override
  BillPaymentsTransactionModel transform() {
    return BillPaymentsTransactionModel(
        billPaymentsTransactionData: (this.response!.content as List<dynamic>)
            .map((e) => BillPaymentsTransactionDataEntity.fromJson(e).transform())
            .toList());
  }
}
