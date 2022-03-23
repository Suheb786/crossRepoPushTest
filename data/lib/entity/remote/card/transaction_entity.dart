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
  @JsonKey(name: "trnxType")
  final String? trnxType;
  @JsonKey(name: "memo")
  final String? memo;

  TransactionEntity(
      {this.id,
      this.description,
      this.transactionTime,
      this.amount,
      this.amountCur,
      this.balance,
      this.balanceCur,
      this.trnxType,
      this.memo: ""});

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
        id: this.id ?? 0,
        amount: this.amount ?? 0.0,
        description: this.description ?? '',
        time: this.transactionTime,
        amountCur: this.amountCur ?? 'JOD',
        balance: this.balance ?? 0.0,
        balanceCur: this.balanceCur ?? 'JOD',
        trnxType: this.trnxType ?? 'D',
        memo: this.memo ?? '');
  }
}
