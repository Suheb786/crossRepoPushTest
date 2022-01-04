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

  TransactionEntity(
      {this.id, this.description, this.transactionTime, this.amount});

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
        time: this.transactionTime);
  }
}
