import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_bill_list_entity.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_payments_transaction_data_entity.g.dart';

@JsonSerializable()
class BillPaymentsTransactionDataEntity
    extends BaseLayerDataTransformer<BillPaymentsTransactionDataEntity, BillPaymentsTransactionData> {
  @JsonKey(name: "label")
  final dynamic label;
  @JsonKey(name: "transactionList")
  final List<BillPaymentsTransactionListEntity>? billPaymentsTransactionList;

  BillPaymentsTransactionDataEntity({
    this.label,
    this.billPaymentsTransactionList,
  });

  factory BillPaymentsTransactionDataEntity.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentsTransactionDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillPaymentsTransactionDataEntityToJson(this);

  @override
  BillPaymentsTransactionDataEntity restore(BillPaymentsTransactionData data) {
    return BillPaymentsTransactionDataEntity();
  }

  @override
  BillPaymentsTransactionData transform() {
    return BillPaymentsTransactionData(
        billPaymentsTransactionDataList:
            this.billPaymentsTransactionList?.map((e) => e.transform()).toList());
  }
}
