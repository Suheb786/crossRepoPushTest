import 'package:domain/model/dashboard/transactions/transactions.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "transaction_entity.g.dart";

@JsonSerializable()
class TransactionEntity
    implements BaseLayerDataTransformer<TransactionEntity, Transactions> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "time")
  final DateTime? transactionTime;
  @JsonKey(name: "amount")
  final num? amount;
  @JsonKey(name: "balance")
  final num? balance;
  @JsonKey(name: "balanceCUR")
  final String? balanceCur;
  @JsonKey(name: "amountCUR")
  final String? amountCur;
  @JsonKey(name: "TrnxType")
  final String? trnxType;

  TransactionEntity(
      {this.id,
      this.description,
      this.transactionTime,
      this.amount,
      this.amountCur,
      this.balance,
      this.balanceCur,
      this.trnxType});

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionEntityToJson(this);

  @override
  TransactionEntity restore(Transactions response) {
    return TransactionEntity();
  }

  @override
  Transactions transform() {
    return Transactions(
        id: this.id,
        amount: this.amount,
        description: this.description,
        time: this.transactionTime,
        amountCur: this.amountCur,
        balance: this.balance,
        balanceCur: this.balanceCur,
        trnxType: this.trnxType);
  }
}
